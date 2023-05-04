Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7336F6956
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 12:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjEDK4X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 06:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjEDK4S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 06:56:18 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9700349F7
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 03:56:16 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f1e2555b5aso2595805e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 04 May 2023 03:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683197775; x=1685789775;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=61DFu+rr/bcHzfoO+Muj5LHM6DqMfx+IQWaB1CcwUpA=;
        b=EiwI+gAShmb3MMDXn0XqjhPTSM/fr6HoRfKhsrH/CNynyiRL10+ad/RraXJmxz6/3r
         lYmLFws+VfS826dEsFhGNRp9/ZzyMmlrge8Db8Qw3iLEeqCcRNF2j8QLYkJ8LsBlI2rz
         d0vR+xU6HOTKUcFXY7KJ64aqGk0zlEPRjk2fR3gd4IPMpOp3UdZcaU0YdGjbP+vnlL6n
         PQvWB4JH41R5mrrRybwIMmVbKoJL2URvEjOlheBTvCnEtF/DyIYZnflMU/MmHEjoEDHG
         8U7sVupfWz+bdv/CPIry08a9Y6OGDwsAmEXQeA6vzbeyywVxM5rWWLjVMWqgfSyX1lZc
         +LgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683197775; x=1685789775;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=61DFu+rr/bcHzfoO+Muj5LHM6DqMfx+IQWaB1CcwUpA=;
        b=jU0ZrIvVFwi0tcfu79m6A/92PS8TprS+kkzvFxKFfwtfstJSygzOWWN27bpXWdPFAP
         lZQkiF7yr+QvyFNNY/6XBF1tOQs+VAd5eejJCYDTErgD6xR6zZh4NqzJfLq7TPRL6mZp
         dZ4KYfhk7cUwsaJxoUW/Lri5HXlKAXXoC5DpHNTCT7ptBEOoMvMeWtNogbPJFgYTTgj7
         nE83TqBDdf3w3102jhiFgdsw/FVZjgcB7akrfpVn4F0B5NCmLOE0b2ogwRDQnGjtDMcD
         kPIsimWUjzsREOUriJf9dtZwZfPnrUPvUArPW98zFsuVh5KjKOuzjS4wvfdx0JPuozHN
         5YYA==
X-Gm-Message-State: AC+VfDzAFPolPu7IN5C2/haumfeJM5ly0FabiXMYm8tuME4fgtjQR9kM
        shvE7MObweEzIHfCNYv1piXY9HYeqld1RwkdtlY=
X-Google-Smtp-Source: ACHHUZ4DuUR7W83gk6GP0MbYpPb4sB+kVzYPV+GtQO7x4jgKKg6zRfF40+bMbUceAGtucoSJBa0kuw==
X-Received: by 2002:a1c:7209:0:b0:3f1:78d0:fc45 with SMTP id n9-20020a1c7209000000b003f178d0fc45mr16826765wmc.28.1683197775086;
        Thu, 04 May 2023 03:56:15 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l2-20020a1c7902000000b003f195d540d9sm4507885wme.14.2023.05.04.03.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 03:56:13 -0700 (PDT)
Date:   Thu, 4 May 2023 13:56:06 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     s.hauer@pengutronix.de
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] wifi: rtw88: usb: fix priority queue to endpoint mapping
Message-ID: <c3f70197-829d-48ed-ae15-66a9de80fa90@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Sascha Hauer,

The patch a6f187f92bcc: "wifi: rtw88: usb: fix priority queue to
endpoint mapping" from Apr 17, 2023, leads to the following Smatch
static checker warning:

drivers/net/wireless/realtek/rtw88/usb.c:219 rtw_usb_parse() warn: assigning (-22) to unsigned variable 'rtwusb->qsel_to_ep[8]'
drivers/net/wireless/realtek/rtw88/usb.c:220 rtw_usb_parse() warn: assigning (-22) to unsigned variable 'rtwusb->qsel_to_ep[9]'
drivers/net/wireless/realtek/rtw88/usb.c:221 rtw_usb_parse() warn: assigning (-22) to unsigned variable 'rtwusb->qsel_to_ep[10]'
drivers/net/wireless/realtek/rtw88/usb.c:222 rtw_usb_parse() warn: assigning (-22) to unsigned variable 'rtwusb->qsel_to_ep[11]'
drivers/net/wireless/realtek/rtw88/usb.c:223 rtw_usb_parse() warn: assigning (-22) to unsigned variable 'rtwusb->qsel_to_ep[12]'
drivers/net/wireless/realtek/rtw88/usb.c:224 rtw_usb_parse() warn: assigning (-22) to unsigned variable 'rtwusb->qsel_to_ep[13]'
drivers/net/wireless/realtek/rtw88/usb.c:225 rtw_usb_parse() warn: assigning (-22) to unsigned variable 'rtwusb->qsel_to_ep[14]'
drivers/net/wireless/realtek/rtw88/usb.c:226 rtw_usb_parse() warn: assigning (-22) to unsigned variable 'rtwusb->qsel_to_ep[15]'

drivers/net/wireless/realtek/rtw88/usb.c
    137 static int rtw_usb_parse(struct rtw_dev *rtwdev,
    138                          struct usb_interface *interface)
    139 {
    140         struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
    141         struct usb_host_interface *host_interface = &interface->altsetting[0];
    142         struct usb_interface_descriptor *interface_desc = &host_interface->desc;
    143         struct usb_endpoint_descriptor *endpoint;
    144         struct usb_device *usbd = interface_to_usbdev(interface);
    145         int num_out_pipes = 0;
    146         int i;
    147         u8 num;
    148         const struct rtw_chip_info *chip = rtwdev->chip;
    149         const struct rtw_rqpn *rqpn;
    150 
    151         for (i = 0; i < interface_desc->bNumEndpoints; i++) {
    152                 endpoint = &host_interface->endpoint[i].desc;
    153                 num = usb_endpoint_num(endpoint);
    154 
    155                 if (usb_endpoint_dir_in(endpoint) &&
    156                     usb_endpoint_xfer_bulk(endpoint)) {
    157                         if (rtwusb->pipe_in) {
    158                                 rtw_err(rtwdev, "IN pipes overflow\n");
    159                                 return -EINVAL;
    160                         }
    161 
    162                         rtwusb->pipe_in = num;
    163                 }
    164 
    165                 if (usb_endpoint_dir_in(endpoint) &&
    166                     usb_endpoint_xfer_int(endpoint)) {
    167                         if (rtwusb->pipe_interrupt) {
    168                                 rtw_err(rtwdev, "INT pipes overflow\n");
    169                                 return -EINVAL;
    170                         }
    171 
    172                         rtwusb->pipe_interrupt = num;
    173                 }
    174 
    175                 if (usb_endpoint_dir_out(endpoint) &&
    176                     usb_endpoint_xfer_bulk(endpoint)) {
    177                         if (num_out_pipes >= ARRAY_SIZE(rtwusb->out_ep)) {
    178                                 rtw_err(rtwdev, "OUT pipes overflow\n");
    179                                 return -EINVAL;
    180                         }
    181 
    182                         rtwusb->out_ep[num_out_pipes++] = num;
    183                 }
    184         }
    185 
    186         switch (usbd->speed) {
    187         case USB_SPEED_LOW:
    188         case USB_SPEED_FULL:
    189                 rtwusb->bulkout_size = RTW_USB_FULL_SPEED_BULK_SIZE;
    190                 break;
    191         case USB_SPEED_HIGH:
    192                 rtwusb->bulkout_size = RTW_USB_HIGH_SPEED_BULK_SIZE;
    193                 break;
    194         case USB_SPEED_SUPER:
    195                 rtwusb->bulkout_size = RTW_USB_SUPER_SPEED_BULK_SIZE;
    196                 break;
    197         default:
    198                 rtw_err(rtwdev, "failed to detect usb speed\n");
    199                 return -EINVAL;
    200         }
    201 
    202         rtwdev->hci.bulkout_num = num_out_pipes;
    203 
    204         if (num_out_pipes < 1 || num_out_pipes > 4) {
    205                 rtw_err(rtwdev, "invalid number of endpoints %d\n", num_out_pipes);
    206                 return -EINVAL;
    207         }
    208 
    209         rqpn = &chip->rqpn_table[num_out_pipes];
    210 
    211         rtwusb->qsel_to_ep[TX_DESC_QSEL_TID0] = dma_mapping_to_ep(rqpn->dma_map_be);
    212         rtwusb->qsel_to_ep[TX_DESC_QSEL_TID1] = dma_mapping_to_ep(rqpn->dma_map_bk);
    213         rtwusb->qsel_to_ep[TX_DESC_QSEL_TID2] = dma_mapping_to_ep(rqpn->dma_map_bk);
    214         rtwusb->qsel_to_ep[TX_DESC_QSEL_TID3] = dma_mapping_to_ep(rqpn->dma_map_be);
    215         rtwusb->qsel_to_ep[TX_DESC_QSEL_TID4] = dma_mapping_to_ep(rqpn->dma_map_vi);
    216         rtwusb->qsel_to_ep[TX_DESC_QSEL_TID5] = dma_mapping_to_ep(rqpn->dma_map_vi);
    217         rtwusb->qsel_to_ep[TX_DESC_QSEL_TID6] = dma_mapping_to_ep(rqpn->dma_map_vo);
    218         rtwusb->qsel_to_ep[TX_DESC_QSEL_TID7] = dma_mapping_to_ep(rqpn->dma_map_vo);
--> 219         rtwusb->qsel_to_ep[TX_DESC_QSEL_TID8] = -EINVAL;

Can't save negative error codes to a u8.

    220         rtwusb->qsel_to_ep[TX_DESC_QSEL_TID9] = -EINVAL;
    221         rtwusb->qsel_to_ep[TX_DESC_QSEL_TID10] = -EINVAL;
    222         rtwusb->qsel_to_ep[TX_DESC_QSEL_TID11] = -EINVAL;
    223         rtwusb->qsel_to_ep[TX_DESC_QSEL_TID12] = -EINVAL;
    224         rtwusb->qsel_to_ep[TX_DESC_QSEL_TID13] = -EINVAL;
    225         rtwusb->qsel_to_ep[TX_DESC_QSEL_TID14] = -EINVAL;
    226         rtwusb->qsel_to_ep[TX_DESC_QSEL_TID15] = -EINVAL;
    227         rtwusb->qsel_to_ep[TX_DESC_QSEL_BEACON] = dma_mapping_to_ep(rqpn->dma_map_hi);
    228         rtwusb->qsel_to_ep[TX_DESC_QSEL_HIGH] = dma_mapping_to_ep(rqpn->dma_map_hi);
    229         rtwusb->qsel_to_ep[TX_DESC_QSEL_MGMT] = dma_mapping_to_ep(rqpn->dma_map_mg);
    230         rtwusb->qsel_to_ep[TX_DESC_QSEL_H2C] = dma_mapping_to_ep(rqpn->dma_map_hi);
    231 
    232         return 0;
    233 }

regards,
dan carpenter

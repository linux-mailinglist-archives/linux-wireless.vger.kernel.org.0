Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A921F7D6153
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 07:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjJYFx1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 01:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYFx0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 01:53:26 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D64512A
        for <linux-wireless@vger.kernel.org>; Tue, 24 Oct 2023 22:53:24 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c59a4dd14cso13566141fa.2
        for <linux-wireless@vger.kernel.org>; Tue, 24 Oct 2023 22:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698213203; x=1698818003; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8F3msEI0NNnogByDKUb2wCZqQuviJExvBgldLt3ZlvE=;
        b=Lva7sZoPHVQu+184EWo0RsLTg7bpPcGKB56JdL9eR6Szk5lwg+FH6crIJGO3xy+E5C
         Vrr4AVxI9hitt9oyYrd2IvX7e/rq2y2muI4pyRbKQrS7rh0c77IpGqoWs6tKeq7JiiQG
         dTbPeuIFkZTS86Zt3L0THq2QW/+rpoSfDvFQNCxZBRREdoWg3JFAwiVC2/R9v8S1RSJG
         tyFZh7b4hbVTmP5doBiX0Y2PIiS8rSAvVSaWlGp8Mj17ejj/oIweHbHoY+Xip7ZHuo+P
         DbTJiPKUNIk5i0ZU6kXB2/lJMztNp+u4AO5QEe3M7E/D/2Ls3TeHoXy6LYkzeFodo1X3
         9/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698213203; x=1698818003;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8F3msEI0NNnogByDKUb2wCZqQuviJExvBgldLt3ZlvE=;
        b=JL9O4f+2vNsY1SJ6F3UEReQdg1awIkpmmNzbdpur7moBto+SsSbKLsIyA0XXhUg8mW
         osXydswo2xRYpoUFThVzetJtziFdTNPibdVHf7XVqB7Y8ntUjIbNEKqaADad5txn095e
         GF04fwuSNZGEitVe9U4x6azINZJBDUky2islZtIha/qgNV2syTfRTnjp+bLbSDl+/tX9
         yA1cpQs9F7qihgwf0ZvkNjxAUG4kq7gaS+I6ydIgEtCjp+GyAVhFaUioLcXhNvVg5vGl
         zFzctIhe3FPZwb8VRnnzGXAn/G7p+Rh07VQ/egWWSrkrpoCE31LrXkPV7aAPryrvaqaW
         0uaA==
X-Gm-Message-State: AOJu0YzaiTC+nhbfXwWkGd8uJgprezns5bDBQY0w66vAVHG0R5F0cnjy
        nI+4WhCd9k1Plk6pGclXa9TxdA==
X-Google-Smtp-Source: AGHT+IE59jt89xQBsYBDyyHfSBGyyHZRwTtgpdSedjHnTr0d1elxOMUQnt88BGGvOWF4kp0tXPrBTg==
X-Received: by 2002:a2e:8854:0:b0:2b9:e6a0:5c3a with SMTP id z20-20020a2e8854000000b002b9e6a05c3amr10843883ljj.48.1698213202735;
        Tue, 24 Oct 2023 22:53:22 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i18-20020a05600c2d9200b003fd2d3462fcsm226959wmg.1.2023.10.24.22.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 22:53:22 -0700 (PDT)
Date:   Wed, 25 Oct 2023 08:53:17 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     itai.allouche@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] wifi: iwlwifi: mvm: add start mac ctdp sum calculation
 debugfs handler
Message-ID: <c11aae74-85d7-461a-ade8-d99dda9701eb@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello iallouch,

The patch 706f1b5d83ca: "wifi: iwlwifi: mvm: add start mac ctdp sum
calculation debugfs handler" from Oct 4, 2023 (linux-next), leads to
the following Smatch static checker warning:

	drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c:64 iwl_dbgfs_stop_ctdp_write()
	error: uninitialized symbol 'force'.

drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
    49 static ssize_t iwl_dbgfs_stop_ctdp_write(struct iwl_mvm *mvm, char *buf,
    50                                          size_t count, loff_t *ppos)
    51 {
    52         int ret;
    53         bool force;
    54 
    55         if (!kstrtobool(buf, &force))
    56                 IWL_DEBUG_INFO(mvm,
    57                                "force start is %d [0=disabled, 1=enabled]\n",
    58                                force);

If kstrtobool() fails then force is uninitialized.  This should be:

	ret = kstrtobool(buf, &force);
	if (ret)
		return ret;

I feel like the IWL_DEBUG_INFO() does not add anything and should be
deleted.  Right now it's printing on the success path...

    59 
    60         /* we allow skipping cap support check and force stop ctdp
    61          * statistics collection and with guerantee that it is
    62          * safe to use.
    63          */
--> 64         if (!force && !iwl_mvm_is_ctdp_supported(mvm))
    65                 return -EOPNOTSUPP;
    66 
    67         if (!iwl_mvm_firmware_running(mvm) ||
    68             mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR)
    69                 return -EIO;
    70 
    71         mutex_lock(&mvm->mutex);
    72         ret = iwl_mvm_ctdp_command(mvm, CTDP_CMD_OPERATION_STOP, 0);
    73         mutex_unlock(&mvm->mutex);
    74 
    75         return ret ?: count;
    76 }

regards,
dan carpenter

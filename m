Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D22C64168B
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Dec 2022 13:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiLCMJs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Dec 2022 07:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiLCMJr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Dec 2022 07:09:47 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649A55F78
        for <linux-wireless@vger.kernel.org>; Sat,  3 Dec 2022 04:09:46 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id ay8-20020a05600c1e0800b003d0808d2826so3472438wmb.1
        for <linux-wireless@vger.kernel.org>; Sat, 03 Dec 2022 04:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wZNjLyfcR24Uofkeztq5VOnSbTFddNyUrBeNzR+noDA=;
        b=E5cpp/T+D7FM/oH8la/aMSSMIwOL97wJPn2M5fR/K6vhOT38QJ31WppKIXc5csrS0b
         OIz3jPQzCWXeXmCKTz6w4JjMFq+6uTKSDHbEeVfYYywcr220+I1/JLMmNZuzBS/5be81
         kBMOKp/nRC+lYakV9W5c1FwZYbOtwQyaWYIf81ZwFyhZVhvbqFfVSd/W+ocEKr4m8IJ2
         puuIbNX0sAM2/fSQp/9JlTnDOLkFJ5+4KuVh82L5hyiheITgSgpuyvFeRD5cnQSRJZgk
         yF7o4WBZuSm745hu0T7l+XW7sf7wcth4/xM3DlQ0k+r6sZQ64ph6xBTyZuF7KdMBd6ok
         aGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZNjLyfcR24Uofkeztq5VOnSbTFddNyUrBeNzR+noDA=;
        b=1DcvveWdV4l8T9gxY0M6ikkzVNHrvgOdx5ThSQ+mHzNEG/KNI/cqatr3gg6spSs3l0
         lZWpw96JjO2yaYKtdpjKXvIL5yTayveMGr/RWpa9PEqUYm4nH12B3Dyn0UnR1ClI+Ux/
         kTAGeHOjZyL5sZnEEELipXlMrHOERAcQycCf0IvLc5XQuDLVpq3lMfXHkW13BN8NSaMk
         KD+Akst5Np1uC+9HAH3OMmNnsf02xfwGrJ4PNXOyG/d4ut6hpdbD7CBZDjEA9onsVUK0
         8aFP+MBhKs19AywHD3N5bNqmi5Wn9AzVh2LxDOwCe2nKjM/ismimbSh4irCB8Hgf0Fj0
         OYmg==
X-Gm-Message-State: ANoB5plqUaafS1o69SK1v0P5DuXm2ciRrmrJm7idCEevxg5q9xEYxl4Y
        pwpy8RBjXKL5/H2eY9aJzF3mtefLy3Q=
X-Google-Smtp-Source: AA0mqf6kYr6jkysyhWybj9YwusCGCHXYkXg5Qj7vAFabVqvGqz3iAQgKRojZ2hImB7lFX1iOwdZM+w==
X-Received: by 2002:a05:600c:1f1b:b0:3c5:a867:e59f with SMTP id bd27-20020a05600c1f1b00b003c5a867e59fmr39465913wmb.146.1670069384757;
        Sat, 03 Dec 2022 04:09:44 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r15-20020adfdc8f000000b002425787c5easm835888wrj.96.2022.12.03.04.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 04:09:44 -0800 (PST)
Date:   Sat, 3 Dec 2022 15:09:38 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] wifi: mt76: move mt76_rate_power from core to mt76x02
 driver code
Message-ID: <Y4s8gszsMUvPfIV9@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Felix Fietkau,

The patch b376d96362d8: "wifi: mt76: move mt76_rate_power from core
to mt76x02 driver code" from Sep 28, 2022, leads to the following
Smatch static checker warning:

	drivers/net/wireless/mediatek/mt76/mt76x0/phy.c:645 mt76x0_phy_get_target_power()
	error: buffer overflow 'dev->rate_power.vht' 2 <= 9

drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
    635                 *target_power = cur_power + dev->rate_power.ofdm[index];
    636                 *target_pa_power = mt76x0_phy_get_rf_pa_mode(dev, 0, index + 4);
    637                 break;
    638         }
    639         case 4:
    640                 /* vht rates */
    641                 tx_rate = info[1] & 0xf;
    642                 if (tx_rate > 9)
                            ^^^^^^^^^^^

    643                         return -EINVAL;
    644 
--> 645                 *target_power = cur_power + dev->rate_power.vht[tx_rate];

In the original code this was a 10 element array but now it's only 2
elements.

    646                 *target_pa_power = mt76x0_phy_get_rf_pa_mode(dev, 1, tx_rate);
    647                 break;
    648         default:
    649                 /* ht rates */
    650                 tx_rate = info[1] & 0x7f;
    651                 if (tx_rate > 9)
    652                         return -EINVAL;
    653 
    654                 *target_power = cur_power + dev->rate_power.ht[tx_rate];
    655                 *target_pa_power = mt76x0_phy_get_rf_pa_mode(dev, 1, tx_rate);
    656                 break;
    657         }
    658 
    659         return 0;
    660 }

regards,
dan carpenter

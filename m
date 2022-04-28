Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FD5513F2D
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 01:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353389AbiD1Xq7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Apr 2022 19:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353323AbiD1Xq7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Apr 2022 19:46:59 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B137A999
        for <linux-wireless@vger.kernel.org>; Thu, 28 Apr 2022 16:43:40 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id v4so8596722ljd.10
        for <linux-wireless@vger.kernel.org>; Thu, 28 Apr 2022 16:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aqE1ybcBL/9Io1ScprRN5X8xoUPpj/53FgjLBSm+a3E=;
        b=lxki6vTYGORyK08qGDPKngEowCLCBVaCBSZEGWQlu6nWE2K/HDz5TEWPlIEh6JYjA7
         ol6W4DSIJpTExiwf0DhTEPfTjF00/AVCWgAVP9OFG3r4NlmjPnQ0vxz7uefor6cPQ/KN
         nQPBTbh47G1Frsy42kFTAon9ha9lF6/L2byg5zr98ok6bbNXxfcZj+BFB44+v6dcehRv
         g41qCNQaXBIjQ+hZJFz8m7uuIp0KbGXsn35ykSIjKtt834xscr61yTLvlSbdUM4sNF5h
         FEaD3/M6oV/Wo2xeUDoAEUpwUvLf8QZ7F90Evzp1E3wdFxvZVO6qhgzXnnOY0MGBmuyv
         4/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aqE1ybcBL/9Io1ScprRN5X8xoUPpj/53FgjLBSm+a3E=;
        b=lt0fCCVn0DZ8cXR1UDVV96pXcbh/cSLLFAfPEnlR57OGVM7MI/6fJcQdBapq9huimb
         Is1d6YqxXRSHcaO+LL9jI0F4huLTuSa591El04bEZyoI8kN4VgO+w+BGqRAjHnTmZPvZ
         qG7pthvEpJz/X8YfSoQteGh2dEnMHycu4fa04G+rmrBMiV+pnqXfYpQEoyZGORvVI4Xb
         mHxjq576+mc3GJcvxQ1ibemnj0N4ArgOkpfzkJyHVGqDVUTXkq0dSMvp2oj+VRURi8a5
         w0Rjj1tw7BpT4GhphHksYAYCpHx69vFpCRAJk9mVq35CAhPOzVKoEewsuOoYA6Cmo9xe
         bwVQ==
X-Gm-Message-State: AOAM531V3L6ZQuiEP/BmniLw7mF1FRKoiaTu9oBXEFLJ4nT029YvTAta
        mxo/el/x78gc2Frn713a1/Hhtw==
X-Google-Smtp-Source: ABdhPJyRc/4TPe9KRmlXDLktw2VFls0ZibH+HcyAdhSUyaAKghaY4CA0SFGQB5P0Pse71H7ZMlMUmQ==
X-Received: by 2002:a2e:854b:0:b0:24f:b98:e2d2 with SMTP id u11-20020a2e854b000000b0024f0b98e2d2mr17650865ljj.165.1651189419275;
        Thu, 28 Apr 2022 16:43:39 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w22-20020a194916000000b0046ba5a6ff16sm109966lfa.11.2022.04.28.16.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 16:43:38 -0700 (PDT)
Message-ID: <332e62e5-b04d-3a6a-38fe-924d056bf0f8@linaro.org>
Date:   Fri, 29 Apr 2022 02:43:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PULL linux-firmware] ath10k & ath11k firmware 20220423
Content-Language: en-GB
To:     Kalle Valo <kvalo@qca.qualcomm.com>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
References: <BYAPR02MB4567E377F14F272DFF48907A92FA9@BYAPR02MB4567.namprd02.prod.outlook.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <BYAPR02MB4567E377F14F272DFF48907A92FA9@BYAPR02MB4567.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

On 27/04/2022 11:32, Kalle Valo wrote:
> Add support for QCN9074 and WCN6750 ath11k hardware families. Also
> there are several updates to existing firmwares and board files for both ath10k
> and ath11k.
> 
> Please let me know if there are any problems.

I noticed that this pull request doesn't include the board file for 
WCN3990. Is there any issue with it that we can solve on our side?

> 
> Kalle
> 
> The following changes since commit e6553076626e932983b1947e1cc593421cb83aa8:
> 
>    Mellanox: Add new mlxsw_spectrum firmware xx.2010.1502 (2022-04-21 06:46:21 -0400)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/linux-firmware.git ath10k-20220423
> 
> for you to fetch changes up to 4a0e59f95830817b1601631281191a5c3327d138:
> 
>    ath11k: QCA6390 hw2.0: update to WLAN.HST.1.0.1-05266-QCAHSTSWPLZ_V2_TO_X86-1 (2022-04-27 11:23:17 +0300)
> 
> ----------------------------------------------------------------
> Kalle Valo (19):
>        ath11k: IPQ6018 hw1.0: update board-2.bin
>        ath11k: IPQ6018 hw1.0: update to WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1
>        ath11k: IPQ8074 hw2.0: update board-2.bin
>        ath11k: IPQ8074 hw2.0: update to WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1
>        ath11k: QCA6390 hw2.0: update board-2.bin
>        ath11k: QCN9074 hw1.0: add board-2.bin
>        ath11k: QCN9074 hw1.0: add to WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1
>        ath11k: WCN6750 hw1.0: add board-2.bin
>        ath11k: WCN6750 hw1.0: add to WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
>        ath11k: WCN6855 hw2.0: update to WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.7
>        ath10k: QCA99X0 hw2.0: add board-2.bin
>        ath10k: QCA4019 hw1.0: update board-2.bin
>        ath10k: QCA6174 hw3.0: update firmware-6.bin to WLAN.RM.4.4.1-00288-QCARMSWPZ-1
>        ath10k: QCA6174 hw3.0: update board-2.bin
>        ath10k: QCA9888 hw2.0: update firmware-5.bin to 10.4-3.9.0.2-00156
>        ath10k: QCA9888 hw2.0: update board-2.bin
>        ath10k: QCA9984 hw1.0: update firmware-5.bin to 10.4-3.9.0.2-00156
>        ath10k: QCA9984 hw1.0: update board-2.bin
>        ath11k: QCA6390 hw2.0: update to WLAN.HST.1.0.1-05266-QCAHSTSWPLZ_V2_TO_X86-1
> 
>   WHENCE                              |   34 +-
>   ath10k/QCA4019/hw1.0/board-2.bin    |  Bin 607304 -> 1129788 bytes
>   ath10k/QCA6174/hw3.0/board-2.bin    |  Bin 715444 -> 731852 bytes
>   ath10k/QCA6174/hw3.0/firmware-6.bin |  Bin 702844 -> 706004 bytes
>   ath10k/QCA9888/hw2.0/board-2.bin    |  Bin 84928 -> 133540 bytes
>   ath10k/QCA9888/hw2.0/firmware-5.bin |  Bin 691292 -> 693604 bytes
>   ath10k/QCA9984/hw1.0/board-2.bin    |  Bin 171916 -> 220528 bytes
>   ath10k/QCA9984/hw1.0/firmware-5.bin |  Bin 679288 -> 681568 bytes
>   ath10k/QCA99X0/hw2.0/board-2.bin    |  Bin 0 -> 157680 bytes
>   ath10k/QCA99X0/hw2.0/board.bin      |  Bin 12064 -> 0 bytes
>   ath11k/IPQ6018/hw1.0/Notice.txt     | 3916 +++++++++++++++++--
>   ath11k/IPQ6018/hw1.0/board-2.bin    |  Bin 787208 -> 787208 bytes
>   ath11k/IPQ6018/hw1.0/m3_fw.b01      |  Bin 6712 -> 6712 bytes
>   ath11k/IPQ6018/hw1.0/m3_fw.b02      |  Bin 294912 -> 294912 bytes
>   ath11k/IPQ6018/hw1.0/m3_fw.mdt      |  Bin 6860 -> 6860 bytes
>   ath11k/IPQ6018/hw1.0/q6_fw.b00      |  Bin 340 -> 340 bytes
>   ath11k/IPQ6018/hw1.0/q6_fw.b01      |  Bin 7000 -> 7000 bytes
>   ath11k/IPQ6018/hw1.0/q6_fw.b02      |  Bin 4696 -> 4696 bytes
>   ath11k/IPQ6018/hw1.0/q6_fw.b03      |  Bin 2357712 -> 2557136 bytes
>   ath11k/IPQ6018/hw1.0/q6_fw.b04      |  Bin 370560 -> 412064 bytes
>   ath11k/IPQ6018/hw1.0/q6_fw.b05      |  Bin 175588 -> 198052 bytes
>   ath11k/IPQ6018/hw1.0/q6_fw.b07      |  Bin 8936 -> 9416 bytes
>   ath11k/IPQ6018/hw1.0/q6_fw.b08      |  Bin 409914 -> 453364 bytes
>   ath11k/IPQ6018/hw1.0/q6_fw.mdt      |  Bin 7340 -> 7340 bytes
>   ath11k/IPQ8074/hw2.0/Notice.txt     | 3916 +++++++++++++++++--
>   ath11k/IPQ8074/hw2.0/board-2.bin    |  Bin 1311380 -> 1311380 bytes
>   ath11k/IPQ8074/hw2.0/m3_fw.b01      |  Bin 136 -> 136 bytes
>   ath11k/IPQ8074/hw2.0/m3_fw.b02      |  Bin 327680 -> 327680 bytes
>   ath11k/IPQ8074/hw2.0/m3_fw.mdt      |  Bin 284 -> 284 bytes
>   ath11k/IPQ8074/hw2.0/q6_fw.b00      |  Bin 340 -> 340 bytes
>   ath11k/IPQ8074/hw2.0/q6_fw.b01      |  Bin 328 -> 328 bytes
>   ath11k/IPQ8074/hw2.0/q6_fw.b02      |  Bin 4696 -> 4696 bytes
>   ath11k/IPQ8074/hw2.0/q6_fw.b03      |  Bin 2589264 -> 2934864 bytes
>   ath11k/IPQ8074/hw2.0/q6_fw.b04      |  Bin 985504 -> 1009888 bytes
>   ath11k/IPQ8074/hw2.0/q6_fw.b05      |  Bin 387076 -> 243652 bytes
>   ath11k/IPQ8074/hw2.0/q6_fw.b07      |  Bin 7048 -> 9816 bytes
>   ath11k/IPQ8074/hw2.0/q6_fw.b08      |  Bin 424524 -> 486546 bytes
>   ath11k/IPQ8074/hw2.0/q6_fw.mdt      |  Bin 668 -> 668 bytes
>   ath11k/QCA6390/hw2.0/Notice.txt     | 4839 ++++++++++++++++-------
>   ath11k/QCA6390/hw2.0/amss.bin       |  Bin 3609456 -> 3628672 bytes
>   ath11k/QCA6390/hw2.0/board-2.bin    |  Bin 58016 -> 115984 bytes
>   ath11k/QCA6390/hw2.0/m3.bin         |  Bin 266684 -> 266684 bytes
>   ath11k/QCN9074/hw1.0/Notice.txt     | 4094 +++++++++++++++++++
>   ath11k/QCN9074/hw1.0/amss.bin       |  Bin 0 -> 11905872 bytes
>   ath11k/QCN9074/hw1.0/board-2.bin    |  Bin 0 -> 786836 bytes
>   ath11k/QCN9074/hw1.0/m3.bin         |  Bin 0 -> 340108 bytes
>   ath11k/WCN6750/hw1.0/Notice.txt     | 7380 +++++++++++++++++++++++++++++++++++
>   ath11k/WCN6750/hw1.0/board-2.bin    |  Bin 0 -> 843548 bytes
>   ath11k/WCN6750/hw1.0/wpss.b00       |  Bin 0 -> 340 bytes
>   ath11k/WCN6750/hw1.0/wpss.b01       |  Bin 0 -> 6848 bytes
>   ath11k/WCN6750/hw1.0/wpss.b02       |  Bin 0 -> 10300 bytes
>   ath11k/WCN6750/hw1.0/wpss.b03       |  Bin 0 -> 4096 bytes
>   ath11k/WCN6750/hw1.0/wpss.b04       |  Bin 0 -> 5783231 bytes
>   ath11k/WCN6750/hw1.0/wpss.b05       |  Bin 0 -> 175236 bytes
>   ath11k/WCN6750/hw1.0/wpss.b06       |  Bin 0 -> 266684 bytes
>   ath11k/WCN6750/hw1.0/wpss.b07       |  Bin 0 -> 1176368 bytes
>   ath11k/WCN6750/hw1.0/wpss.b08       |    0
>   ath11k/WCN6750/hw1.0/wpss.mdt       |  Bin 0 -> 7188 bytes
>   ath11k/WCN6855/hw2.0/amss.bin       |  Bin 4972544 -> 4972544 bytes
>   59 files changed, 22238 insertions(+), 1941 deletions(-)
>   create mode 100644 ath10k/QCA99X0/hw2.0/board-2.bin
>   delete mode 100644 ath10k/QCA99X0/hw2.0/board.bin
>   create mode 100644 ath11k/QCN9074/hw1.0/Notice.txt
>   create mode 100644 ath11k/QCN9074/hw1.0/amss.bin
>   create mode 100644 ath11k/QCN9074/hw1.0/board-2.bin
>   create mode 100644 ath11k/QCN9074/hw1.0/m3.bin
>   create mode 100644 ath11k/WCN6750/hw1.0/Notice.txt
>   create mode 100644 ath11k/WCN6750/hw1.0/board-2.bin
>   create mode 100644 ath11k/WCN6750/hw1.0/wpss.b00
>   create mode 100644 ath11k/WCN6750/hw1.0/wpss.b01
>   create mode 100644 ath11k/WCN6750/hw1.0/wpss.b02
>   create mode 100644 ath11k/WCN6750/hw1.0/wpss.b03
>   create mode 100644 ath11k/WCN6750/hw1.0/wpss.b04
>   create mode 100644 ath11k/WCN6750/hw1.0/wpss.b05
>   create mode 100644 ath11k/WCN6750/hw1.0/wpss.b06
>   create mode 100644 ath11k/WCN6750/hw1.0/wpss.b07
>   create mode 100644 ath11k/WCN6750/hw1.0/wpss.b08
>   create mode 100644 ath11k/WCN6750/hw1.0/wpss.mdt


-- 
With best wishes
Dmitry

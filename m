Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363384AB523
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Feb 2022 07:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiBGGlB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Feb 2022 01:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357087AbiBGGOo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Feb 2022 01:14:44 -0500
X-Greylist: delayed 123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 22:14:43 PST
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508AEC043181
        for <linux-wireless@vger.kernel.org>; Sun,  6 Feb 2022 22:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644214483; x=1675750483;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q4Bf9L82tihKoR0vEAiIJKFbpWaB/+VxOKF7u7RB5lQ=;
  b=MJWbChzoaXvWvVS9AQ2wzbUQwh73lbbooUd3t8nBT4PuP+8C+gynEY07
   ghTv1IoTXCIzIzcTFeHcH85YMuVG+q61aECCrfMlvgH1bkPS1F38faHRP
   Ac7zz+/qK/xpBlh/n5QAKIZWvGeNT6g1aFEffCyRviZfGdwl23siLbgou
   8=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 06 Feb 2022 22:12:39 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 22:12:39 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 6 Feb 2022 22:12:39 -0800
Received: from [10.253.38.163] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 6 Feb 2022
 22:12:38 -0800
Message-ID: <1f02d646-892b-1c0a-2081-f4ee579e940a@quicinc.com>
Date:   Mon, 7 Feb 2022 14:12:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 0/2] ath11k: add handler for board-2.bin without
 variant and read SMBIOS
Content-Language: en-US
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20211220064829.17557-1-quic_wgong@quicinc.com>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <20211220064829.17557-1-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

Do you have any comment for this patch set?

On 12/20/2021 2:48 PM, Wen Gong wrote:
> v5:
>     1. rebased to ath.git ath-202112161538
>     2. fix warning "failed to fetch board data for bus=pci,qmi-chip-id=0,qmi-board-id=255,variant=DE_1901 from ath11k/QCA6390/hw2.0/board-2.bin"
>
> v4:
>     1. add helper function ath11k_core_create_fallback_board_name()
>     2. rebased to ath.git ath-202112071521
>
> v3:
>     1. add patch "ath11k: add fallback board name without variant while searching board-2.bin"
>     2. reabsed to latest ath.git master ath-202111221436
>
> v2: rebased to latest ath.git master ath-202111170737
>
> When it does not have matched board name with variant in board-2.bin,
> ath11k will fallback to search without variant.
>
> Also read the variant from SMBIOS.
>
> Wen Gong (2):
>    ath11k: add fallback board name without variant while searching
>      board-2.bin
>    ath11k: add read variant from SMBIOS for download board data
>
>   drivers/net/wireless/ath/ath11k/core.c | 109 +++++++++++++++++++++++--
>   drivers/net/wireless/ath/ath11k/core.h |  11 +++
>   drivers/net/wireless/ath/ath11k/qmi.c  |   4 +
>   3 files changed, 118 insertions(+), 6 deletions(-)
>
>
> base-commit: 12018ad8603a598d773e2cae12542a1981c94886

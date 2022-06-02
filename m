Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FA153C01A
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jun 2022 22:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbiFBU7n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Jun 2022 16:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiFBU7n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Jun 2022 16:59:43 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38DB12AD3
        for <linux-wireless@vger.kernel.org>; Thu,  2 Jun 2022 13:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654203582; x=1685739582;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rPb7XF5GCjQMEUYiYoxIPi2IouI35teuwJMrZ200egU=;
  b=uB7MP57D6ohSJ/OG4KsNIwapYn6/xcMn8n0VEkDqwf9LqfLoWklvOsy5
   loSMTCKFaer6stb2pMw47vC8hdH6iOsGRx+s8qpTWfafPEO01sCAvX2DD
   +SZ9BLrlIHM3D7Lw9Z8deAAr2MpJRzXk33ND/BfxVF4tOaV90xVpFwC1Q
   U=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 02 Jun 2022 13:59:42 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 13:59:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 2 Jun 2022 13:59:41 -0700
Received: from [10.110.9.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 2 Jun 2022
 13:59:39 -0700
Message-ID: <6fe32a06-a960-3a77-37fd-bc51af1b4c4f@quicinc.com>
Date:   Thu, 2 Jun 2022 13:59:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC v2 76/96] cl8k: add stats.c
Content-Language: en-US
To:     <viktor.barna@celeno.com>, <linux-wireless@vger.kernel.org>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        "Maksym Kokhan" <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
 <20220524113502.1094459-77-viktor.barna@celeno.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220524113502.1094459-77-viktor.barna@celeno.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/24/2022 4:34 AM, viktor.barna@celeno.com wrote:
[snip]

> +static void _cl_stats_update_tx(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
> +				struct cl_agg_tx_report *agg_report)
> +{
> +	struct cl_stats *stats = cl_sta->stats;
> +	struct cl_tx_cntrs *cntrs;
> +	union cl_rate_ctrl_info rate_ctrl_info = {
> +		.word = le32_to_cpu(agg_report->rate_cntrl_info)};
> +	u8 bw, nss, mcs, gi, bf;
> +
> +	switch (rate_ctrl_info.field.format_mod) {
> +	case WRS_MODE_HE:
> +		nss = (rate_ctrl_info.field.mcs_index >> 4);
> +		mcs = (rate_ctrl_info.field.mcs_index & 0xF);
> +		gi = rate_ctrl_info.field.gi;
> +
> +		{

why an embedded block? seems to serve no purpose

> +			bw = rate_ctrl_info.field.bw;
> +			bf = agg_report->bf;
> +
> +				cntrs = &stats->tx.he[bw][nss][mcs][gi][bf];

bad indentation

> +		}
> +		break;
> +	case WRS_MODE_VHT:
> +		bw = rate_ctrl_info.field.bw;
> +		nss = (rate_ctrl_info.field.mcs_index >> 4);
> +		mcs = (rate_ctrl_info.field.mcs_index & 0xF);
> +		gi = rate_ctrl_info.field.gi;
> +		bf = agg_report->bf;
> +
> +			cntrs = &stats->tx.vht[bw][nss][mcs][gi][bf];

bad indentation

> +		break;
> +	case WRS_MODE_HT:
> +		bw = rate_ctrl_info.field.bw;
> +		nss = (rate_ctrl_info.field.mcs_index >> 3);
> +		mcs = (rate_ctrl_info.field.mcs_index & 0x7);
> +		gi = rate_ctrl_info.field.gi;
> +		cntrs = &stats->tx.ht[bw][nss][mcs][gi];
> +		break;
> +	case WRS_MODE_OFDM:
> +		mcs = rate_ctrl_info.field.mcs_index - RATE_CTRL_OFFSET_OFDM;
> +		cntrs = &stats->tx.ofdm[mcs];
> +		break;
> +	case WRS_MODE_CCK:
> +		mcs = rate_ctrl_info.field.mcs_index;
> +		cntrs = &stats->tx.cck[mcs];
> +		break;
> +	default:
> +		return;
> +	}

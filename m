Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB68203A3F
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 17:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgFVPER (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 11:04:17 -0400
Received: from mail-eopbgr700137.outbound.protection.outlook.com ([40.107.70.137]:28001
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729204AbgFVPER (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 11:04:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFkMgVMjwIhc1qZ0a2B2uh14jEI2gltgE5h67A1czxDVp3GNK6HSWv0ViMMHH3xZ1mfr+qOhxxDNMl/LADPxH98nlA/qgqXu91ks0lQt1sxVdcSe70qC3LJw/r9d5HqDNu0xUWy446mvABFdDy3iMRGgtCKmdrZjUqM0vcQzMZhehSveDCh0aSUmBsmLimxwL4QZkNRE8x4sl2LcPIoc8fTYbvFLwJ91YIu+pN61QIsOuyY8cntmj8E+uY7WUh5F9GHA4jDI9aK8gE9fwGmcT7dhsbrERS3V7RUDrSraK8L5LO8VsXjJ7lHsaAxeEmrE+M6/scdxDR1uZO8GOccLkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blJyAz7GUAhk2GK3CnCrosrXsh2c0u9hzrgv/FNOo5o=;
 b=gl3hOFOqCe+gNhVa0vF4BvmWUmxH38nZyyb2z2riXdYU6KwYpjotzSTQta0+3to13QM8BBvZXNL7lYmXcLMLl0RMj0v+ChQRmtIe+5uEjFMKTvHXLljdzNKjFSThzvUKl9rd3wMyLZ7HZH2sbMDnJAbcJkqakhZyuF7EGZCCyoQFh9M3o8OMo1lBnE2ZGSSA0ACmrJ3a+Xc/ek9xNPI4SWVsTuuIONGfCI2caByz7G5YvDDdyIzCtrllF4XhVol+vQ8WMvU88Yw+I0euQrGwgoofFMzn+Z6LFQW5oup3qnmiAH8lcAxtVeL1Nlptlb00mnapJxZAAngvtW04HadAUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blJyAz7GUAhk2GK3CnCrosrXsh2c0u9hzrgv/FNOo5o=;
 b=HdvPjs6y4nMwkYib4/olyhrYwtd4fjPRpWVXUAJP8snfWB+2lQppV9nsb0qPUA/ILO2rrRmrx+3vSeE8xKQ9g4dewAqtHLOZN6vWWhrz7X9FE2/HdBuKAQTN3fV/DDGjxsD5f71Ho3hOAlaOO+enfglbSN3VTIKbjuyuQmAAjIU=
Authentication-Results: cypress.com; dkim=none (message not signed)
 header.d=none;cypress.com; dmarc=none action=none header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB4277.namprd06.prod.outlook.com (2603:10b6:a03:16::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.25; Mon, 22 Jun
 2020 15:04:12 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 15:04:12 +0000
Reply-To: chi-hsien.lin@cypress.com
Subject: Re: [PATCH V2 6/6] brcmfmac: initialize the requested dwell time
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Joseph Chuang <joseph.chuang@cypress.com>
References: <20200610152106.175257-1-chi-hsien.lin@cypress.com>
 <20200610152106.175257-7-chi-hsien.lin@cypress.com>
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Message-ID: <40d2e018-d358-d126-b103-6eea553c5d9f@cypress.com>
Date:   Mon, 22 Jun 2020 23:04:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
In-Reply-To: <20200610152106.175257-7-chi-hsien.lin@cypress.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0106.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::47) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.9.112.143] (61.222.14.99) by BYAPR07CA0106.namprd07.prod.outlook.com (2603:10b6:a03:12b::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 15:04:10 +0000
X-Originating-IP: [61.222.14.99]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 976441ab-5faf-43d0-5aa8-08d816bd85d1
X-MS-TrafficTypeDiagnostic: BYAPR06MB4277:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB427746D996DFDC38CC74756ABB970@BYAPR06MB4277.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDBUeIn6HuKKZN1FSHGvUlkoiOQYPPgqH0qq3mhvjetBMcd8DxIn+nCJVx8QG/K4EiHZ4TcFQWN1Smy1Uhh3e6jmb3Ji5L0VQW33xujaCAxiiTfIKkfe/6BRZlwTyklGQFKw5fwXCOOBNuOJ/MjXnb8+zAKnuICCjEpzA31Scaa+HvcCJjrLpds6wUbf39K7pa8Qrw+xxcBtVj+tHUv81nyDCFU+b49NAbElejUD16Xo2PsWUEdevA2D8XS838ZtTLr9fxRahXqZDiLoLQ1yX4AjyrIzNpGdwyi0kmH/MxKyR5biT61iv4dnbGVfJ02x3tvlWz3Jg3Bej50Q/EI/p0FaIZ7o/PXmdy9koGOwuOLZ4qyRr5y9MesL0oZcnDtT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39860400002)(136003)(396003)(366004)(66556008)(86362001)(66946007)(66476007)(2906002)(52116002)(6486002)(6666004)(478600001)(16576012)(54906003)(316002)(31696002)(53546011)(186003)(107886003)(6916009)(26005)(8676002)(5660300002)(36756003)(16526019)(4326008)(8936002)(31686004)(3450700001)(956004)(2616005)(83380400001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: JYgWGw0YLdojPDTTsDsmyqrriPgU7UKnvWPr2CrrcKm0HMuarta1og5i6n41HfEcaxTu/DP47ibzH3o2ukVRv1pvC9GmrIuXO2/kiTlRdk6E8haLlV5Ss7hwjxjlIepESKYhc7Tw7JIxwtaxMIhxOsBCytJ2uj1jYwWMCPau9MA4BwIWH4yWXKb6JzR3KWQ4FQQOxttsyvPxoWeyzthlvtSWDVFZUiCBqpurGI/BbNrWn9OGjcIRPHA6XHaj7R3vyuOFn1mCqLzqo/jdML0O48H8YE2oNPZ8Z/3TJtqNh+1XwHetM/O+65ZLPN1DfE8dGV56SCedLPCdroD2Kl8NpoWeF2HAjsBo4ZzVWqhAZI+hOkzBdaUjtZGT+Q8mX5CQ8RqTiRIiomhA+2cC1BUUxCnKJEtUiddct5wvm7hkZwWiOD+/0y0usz3/jvwrWXwbmSkT/S5ww4WiUbuPgCHuHpFAMPyQsVDBmDpINOEktgo=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 976441ab-5faf-43d0-5aa8-08d816bd85d1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 15:04:12.5993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQx/ZHB3T9y3hJ3AbjGDJOrIJA2b5p1xR3rgecE7FvN840YH0h+J6SSR3THP4aRlPd/Foe3QMuThfz+nOndb0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4277
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 06/10/2020 11:21, Chi-Hsien Lin wrote:
> From: Joseph Chuang <joseph.chuang@cypress.com>
> 
> Commit 9c29da3f4e7e
> ("brcmfmac: Fix P2P Group Formation failure via Go-neg method") did not
> initialize requested_dwell properly, resulting in an always-false dwell
> time overflow check. Fix it by setting the correct requested_dwell
> value.
> 
> Fixes: 4905432b28b7 ("brcmfmac: Fix P2P Group Formation failure via Go-neg method")
> Signed-off-by: Joseph Chuang <joseph.chuang@cypress.com>
> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>

Kalle,

This issue is reported by kernel test robot. Please kindly add below tag 
during commit.

Reported-by: kernel test robot <lkp@intel.com>



> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c      | 5 ++---
>   2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index a757abd7a599..bddd23240609 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -5129,7 +5129,7 @@ brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
>   					      &freq);
>   		chan_nr = ieee80211_frequency_to_channel(freq);
>   		af_params->channel = cpu_to_le32(chan_nr);
> -
> +		af_params->dwell_time = cpu_to_le32(params->wait);
>   		memcpy(action_frame->data, &buf[DOT11_MGMT_HDR_LEN],
>   		       le16_to_cpu(action_frame->len));
>   
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> index d2795dc17c46..debd887e159e 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> @@ -1700,7 +1700,7 @@ static s32 brcmf_p2p_pub_af_tx(struct brcmf_cfg80211_info *cfg,
>   	return err;
>   }
>   
> -static bool brcmf_p2p_check_dwell_overflow(s32 requested_dwell,
> +static bool brcmf_p2p_check_dwell_overflow(u32 requested_dwell,
>   					   unsigned long dwell_jiffies)
>   {
>   	if ((requested_dwell & CUSTOM_RETRY_MASK) &&
> @@ -1738,8 +1738,7 @@ bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
>   	unsigned long dwell_jiffies = 0;
>   	bool dwell_overflow = false;
>   
> -	s32 requested_dwell = af_params->dwell_time;
> -
> +	u32 requested_dwell = le32_to_cpu(af_params->dwell_time);
>   	action_frame = &af_params->action_frame;
>   	action_frame_len = le16_to_cpu(action_frame->len);
>   
> 

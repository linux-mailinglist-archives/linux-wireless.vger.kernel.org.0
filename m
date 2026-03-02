Return-Path: <linux-wireless+bounces-32333-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AUlEefopGlVvQUAu9opvQ
	(envelope-from <linux-wireless+bounces-32333-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 02:33:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B76C1D24F8
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 02:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB64530055F9
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 01:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1B5175A81;
	Mon,  2 Mar 2026 01:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cilhWxmh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dwtHnnzB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B46B430BAA
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 01:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772415200; cv=none; b=fTy3TGr53m2Fo6gDEkAE433p0Th9Li9QGQuUufSLZ1GqR5UEVSiKVP0Q0EkxYXgnt5nT5BkpKVpXAbw4e9D42rbsx5AEo4ZdYk/XoG5LomEa8z2fcCaCVIwiDy5lG0PWqOOZHOr79qQ3/MBz9xV36C3Dc7p+L0tVSBXHrOummE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772415200; c=relaxed/simple;
	bh=eP4k9Z/77oGpW/d7+yfnnd4KAAANHNUpnI9nRSQZcbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BG8M06chQeEkQ+gYI50qhy2/10tCtHxyZQKPfjSv78fQ2U5jSGsbLIGniSxkuG/Rok4mR8XF+47Pn2cQTGzP7DhdJzPkUE6+qcus1XxkPeFod750pHys8Ho5mdie3Dj5jdHM71POvUQ+Dc53OjIdgRp/USbwaGYdt3k5AWUjpRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cilhWxmh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dwtHnnzB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 621NqC5a092351
	for <linux-wireless@vger.kernel.org>; Mon, 2 Mar 2026 01:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4/WFT3zlJhnisnMBi0gqxfNP77w2FhuxBt4m1pdVZ6Q=; b=cilhWxmhe5psCHLT
	BFAMEXSBgPFEWsfMC82w1J2YL9jlcdatb8SUH7TZLWlxDDdR1n1rehE9NFkJ7pGG
	R3x1CURf5/nii810piOsAVX0rjBk9LSQk53Z0ZpRDRucvit+t6eg5HleNlMGjbm7
	GRnmf4FSWl1gigaSCJ1YQ4i/FElzvS/Hw30/Ewd6CoNj0PCUTdpcB/u0LoIbeI9N
	Pkgh1zDwngZqdj2PD8uIpkk7JZ6aXiNftZ9rqWrZcRwx2G4cBwrIyzAXl0c2x7mC
	2lbnDdF3AVro7HFHuBvYT4TORcyr9au0ndxTWKdccqzwbwlWuk6ZnDYoR9JTxzTq
	KgDKlw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksf6kh29-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2026 01:33:17 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c70f19f0f37so2184574a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 01 Mar 2026 17:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772415197; x=1773019997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4/WFT3zlJhnisnMBi0gqxfNP77w2FhuxBt4m1pdVZ6Q=;
        b=dwtHnnzBBt7nhWBOdaFp0QoeJkLnLBi0JNL6s/g/MEfBcWzvk8RsKkP0B0YyTReON7
         QlALgpstLFhnVlOC70NUzIFHU+qjJ+9zn+AFQJejfI0K0q28vOoA6a7hp/o/wwJZBKqy
         gj9oGofbE8S7YP/0F6ivjc4DIU+Z2sLDpg2LtiReWWzedIfE8k83SdX/0NFE5KBx1jri
         YcDNoW50eYNFcvPmTT80OTe4P2oewX1sGv+inX9+wrl7O+J1JAkThU+ZeBKUOesOa2Dw
         rXD6hVxrubPKeCNBYfQevYQCi533ye0lRcw7CQWjGTwQF/VU3Dj/p/87T2MsFuztdWyu
         DTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772415197; x=1773019997;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/WFT3zlJhnisnMBi0gqxfNP77w2FhuxBt4m1pdVZ6Q=;
        b=QvTCU3S+TmRqDUe60t6n+t3hLG4/SlKS2Gx9qYotRnCOxwecvwC2ETeEMKZi8GFN0k
         N1PgK18ftDxnnFORcO2E74LFVkA5akwR8+BlGupGUh9NnfbhMFQf+hXtNIkcYGx5lNL+
         Am7H1Vi7H+07B/jEMV9O4pW55o1z/ThFBefibVKvJtmtdUP6a9ZLujOdyxQLcw5PpaZW
         Ay62vOZ/GODcUGIiDzgPUX341GyHj+hPGKVQI1NRYY5gRvQiPLFsw7H7EI5TwhH3xii4
         /0hxW8O9IV3PQDkDKFqAaJt+jh/KE54CvgNKeuzbHABxE5fRz/d2LLNBe6WFgvcuqezX
         qlpg==
X-Gm-Message-State: AOJu0YyQPq8SpT3FUDugntRfOFBokug2WNWzJnTxp6NhdPhOmTtuk1dD
	A1V/MYMgpBnHQUODbq+f1y0EyVYRsLTQAdMmqPBeJeQ7Affl/ulknA5ILDm6oeSApvAPCern2NB
	SFBQeUieODUI6AxQzDfi52dLmkXPxZd9GhL6MhRJJVAZfKIuu6yAjeUOj2EB3nOkxjuRNpMkBqE
	+dRriw
X-Gm-Gg: ATEYQzzOkpNr78t9SqN3wKjlsnber+xviLO6BGY1QXHo2e6kgDHSY3ypvWYuvkVasrI
	HLV2fMgJdKBE62Vyf7Fw/72uQO2GJ5SZpJYJlwWmC64teg2jvWDhbMHFGm4LEsH5tbF4p4Nv24K
	DZvsS7wGAGm2ePR9YX1nuSbXlRikGOJ9hJ49V6dHAsMfwOyPTlli0IKwWr0vNN3Y/mTFA6pt+OR
	ZNyGLFR0CGHp3updg2s0mKB2PmqruFdX69CrhARfdaEpvnAfQT4yWl2wKp+ZKBx6vkZLGMmBwez
	i74FPw0yr7+d0lf+oD/bfWb5kfwEtElN163vWqbwif7k8eW58UaDB4WhHfBCPgwEDkroyLIcm1t
	SbY0UcN8h6STH8CxCikRsbc4ByV6/Dl0o/ZExsmvpHFDX6e4/PIgQQ+gHVSmmq+rRijePXjgcMU
	vjGz+Miv/Cn1BgBR247B4=
X-Received: by 2002:a05:6a21:7d0c:b0:394:4d99:ff56 with SMTP id adf61e73a8af0-395c460060cmr9434625637.11.1772415196666;
        Sun, 01 Mar 2026 17:33:16 -0800 (PST)
X-Received: by 2002:a05:6a21:7d0c:b0:394:4d99:ff56 with SMTP id adf61e73a8af0-395c460060cmr9434590637.11.1772415196090;
        Sun, 01 Mar 2026 17:33:16 -0800 (PST)
Received: from [10.133.33.249] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69fa4fsm121259915ad.45.2026.03.01.17.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 17:33:15 -0800 (PST)
Message-ID: <cac1f367-2652-4dc5-b569-983d456ffede@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 09:33:13 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Remove the unused argument from
 the Rx data path
To: Karthikeyan Periyasamy <karthikeyan.periyasamy@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260227042128.3494167-1-karthikeyan.periyasamy@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260227042128.3494167-1-karthikeyan.periyasamy@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: h_rk1HHIelEcRqkh8K-RalKR2h9E0xy3
X-Authority-Analysis: v=2.4 cv=JoL8bc4C c=1 sm=1 tr=0 ts=69a4e8dd cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=-IJwqUjvVoObTRxkB34A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDAxMSBTYWx0ZWRfX6f9X/O7NzwsJ
 zZ3TrUunB0gX/FfrZORwSc8oFs1ZvWGn7HEUZQ+0REQ2jnt/dzjP1PV8GjSdWkLnxE8RlCyLXJz
 SxZo6KbA1h2Ps6PdT7PEbYEZ7SS3H12wfD2Lsy6bFIR8nNX7nDnyv+hvoTI7qbjBNwMJhD0LqN6
 B6PTijtOzTPJpCPjW+uU2ftzLIL7sUjSIqbLPDkq8mCTIQ5UqEk0C2FQAhhEsGdexyDIeh2zpZU
 jmnCzVl/XPrEwiBZdcUCLcM6is/FK0A+80cGOfc7/LP7QZxGhVifQnOuwJcqh4Db9n2dmi2plxy
 SX+ONTTZQDoL+W/YuHLsJETQOA37lBarpL6jZ/UbwESEQ2deUuXXzrvTOv92efks0nIWTiEvlL5
 mv9iXL1XNkBh9T0E+ESyP39P/BY2w4AYxnuTaBk6lew/IHHK/sftrbGyp0rRI1Cth63s/EvHh+Z
 fDQnuv4JzMAehxjhQCA==
X-Proofpoint-GUID: h_rk1HHIelEcRqkh8K-RalKR2h9E0xy3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020011
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32333-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3B76C1D24F8
X-Rspamd-Action: no action



On 2/27/2026 12:21 PM, Karthikeyan Periyasamy wrote:
> Currently, the Rx path uses new infrastructure to extract the required HAL
> parameters. Consequently, the HAL Rx descriptor argument is no longer
> needed in the following helper functions. Remove the unused argument from
> the following helper functions.
> 
> ath12k_dp_rx_h_undecap()
> ath12k_dp_rx_check_nwifi_hdr_len_valid()
> ath12k_wifi7_dp_rx_h_mpdu()
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <karthikeyan.periyasamy@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/dp_rx.c       |  2 --
>  drivers/net/wireless/ath/ath12k/dp_rx.h       |  2 --
>  drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 25 ++++++++-----------
>  3 files changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
> index a32ee9f8061a..c0e2b2c1a292 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> @@ -1117,7 +1117,6 @@ static void ath12k_dp_rx_h_undecap_eth(struct ath12k_pdev_dp *dp_pdev,
>  }
>  
>  void ath12k_dp_rx_h_undecap(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu,
> -			    struct hal_rx_desc *rx_desc,
>  			    enum hal_encrypt_type enctype,
>  			    bool decrypted,
>  			    struct hal_rx_desc_data *rx_info)
> @@ -1393,7 +1392,6 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struc
>  EXPORT_SYMBOL(ath12k_dp_rx_deliver_msdu);
>  
>  bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_dp *dp,
> -					    struct hal_rx_desc *rx_desc,
>  					    struct sk_buff *msdu,
>  					    struct hal_rx_desc_data *rx_info)
>  {
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
> index 1ec5382f5995..bd62af0c80d4 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.h
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
> @@ -189,7 +189,6 @@ void ath12k_dp_extract_rx_desc_data(struct ath12k_hal *hal,
>  }
>  
>  void ath12k_dp_rx_h_undecap(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu,
> -			    struct hal_rx_desc *rx_desc,
>  			    enum hal_encrypt_type enctype,
>  			    bool decrypted,
>  			    struct hal_rx_desc_data *rx_info);
> @@ -197,7 +196,6 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struc
>  			       struct sk_buff *msdu,
>  			       struct hal_rx_desc_data *rx_info);
>  bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_dp *dp,
> -					    struct hal_rx_desc *rx_desc,
>  					    struct sk_buff *msdu,
>  					    struct hal_rx_desc_data *rx_info);
>  u64 ath12k_dp_rx_h_get_pn(struct ath12k_dp *dp, struct sk_buff *skb);
> diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
> index 7450938adf65..77a1679b41df 100644
> --- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
> @@ -325,7 +325,6 @@ static void ath12k_wifi7_dp_rx_h_csum_offload(struct sk_buff *msdu,
>  
>  static void ath12k_wifi7_dp_rx_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
>  				      struct sk_buff *msdu,
> -				      struct hal_rx_desc *rx_desc,
>  				      struct hal_rx_desc_data *rx_info)
>  {
>  	struct ath12k_skb_rxcb *rxcb;
> @@ -388,8 +387,7 @@ static void ath12k_wifi7_dp_rx_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
>  	}
>  
>  	ath12k_wifi7_dp_rx_h_csum_offload(msdu, rx_info);
> -	ath12k_dp_rx_h_undecap(dp_pdev, msdu, rx_desc,
> -			       enctype, is_decrypted, rx_info);
> +	ath12k_dp_rx_h_undecap(dp_pdev, msdu, enctype, is_decrypted, rx_info);
>  
>  	if (!is_decrypted || rx_info->is_mcbc)
>  		return;
> @@ -549,14 +547,14 @@ static int ath12k_wifi7_dp_rx_process_msdu(struct ath12k_pdev_dp *dp_pdev,
>  		}
>  	}
>  
> -	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(dp, rx_desc, msdu,
> +	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(dp, msdu,
>  							     rx_info))) {
>  		ret = -EINVAL;
>  		goto free_out;
>  	}
>  
>  	ath12k_dp_rx_h_ppdu(dp_pdev, rx_info);
> -	ath12k_wifi7_dp_rx_h_mpdu(dp_pdev, msdu, rx_desc, rx_info);
> +	ath12k_wifi7_dp_rx_h_mpdu(dp_pdev, msdu, rx_info);
>  
>  	rx_info->rx_status->flag |= RX_FLAG_SKIP_MONITOR | RX_FLAG_DUP_VALIDATED;
>  
> @@ -1030,13 +1028,13 @@ static int ath12k_wifi7_dp_rx_h_verify_tkip_mic(struct ath12k_pdev_dp *dp_pdev,
>  		    RX_FLAG_IV_STRIPPED | RX_FLAG_DECRYPTED;
>  	skb_pull(msdu, hal_rx_desc_sz);
>  
> -	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(dp, rx_desc, msdu,
> +	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(dp, msdu,
>  							     rx_info)))
>  		return -EINVAL;
>  
>  	ath12k_dp_rx_h_ppdu(dp_pdev, rx_info);
> -	ath12k_dp_rx_h_undecap(dp_pdev, msdu, rx_desc,
> -			       HAL_ENCRYPT_TYPE_TKIP_MIC, true, rx_info);
> +	ath12k_dp_rx_h_undecap(dp_pdev, msdu, HAL_ENCRYPT_TYPE_TKIP_MIC, true,
> +			       rx_info);
>  	ieee80211_rx(ath12k_pdev_dp_to_hw(dp_pdev), msdu);
>  	return -EINVAL;
>  }
> @@ -1588,7 +1586,6 @@ static int ath12k_wifi7_dp_rx_h_null_q_desc(struct ath12k_pdev_dp *dp_pdev,
>  	struct ath12k_dp *dp = dp_pdev->dp;
>  	struct ath12k_base *ab = dp->ab;
>  	u16 msdu_len = rx_info->msdu_len;
> -	struct hal_rx_desc *desc = (struct hal_rx_desc *)msdu->data;
>  	u8 l3pad_bytes = rx_info->l3_pad_bytes;
>  	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
>  	u32 hal_rx_desc_sz = dp->ab->hal.hal_desc_sz;
> @@ -1632,11 +1629,11 @@ static int ath12k_wifi7_dp_rx_h_null_q_desc(struct ath12k_pdev_dp *dp_pdev,
>  		skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
>  		skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
>  	}
> -	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(dp, desc, msdu, rx_info)))
> +	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(dp, msdu, rx_info)))
>  		return -EINVAL;
>  
>  	ath12k_dp_rx_h_ppdu(dp_pdev, rx_info);
> -	ath12k_wifi7_dp_rx_h_mpdu(dp_pdev, msdu, desc, rx_info);
> +	ath12k_wifi7_dp_rx_h_mpdu(dp_pdev, msdu, rx_info);
>  
>  	rxcb->tid = rx_info->tid;
>  
> @@ -1673,7 +1670,7 @@ static bool ath12k_wifi7_dp_rx_h_tkip_mic_err(struct ath12k_pdev_dp *dp_pdev,
>  	skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
>  	skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
>  
> -	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(dp, desc, msdu, rx_info)))
> +	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(dp, msdu, rx_info)))
>  		return true;
>  
>  	ath12k_dp_rx_h_ppdu(dp_pdev, rx_info);
> @@ -1681,8 +1678,8 @@ static bool ath12k_wifi7_dp_rx_h_tkip_mic_err(struct ath12k_pdev_dp *dp_pdev,
>  	rx_info->rx_status->flag |= (RX_FLAG_MMIC_STRIPPED | RX_FLAG_MMIC_ERROR |
>  				     RX_FLAG_DECRYPTED);
>  
> -	ath12k_dp_rx_h_undecap(dp_pdev, msdu, desc,
> -			       HAL_ENCRYPT_TYPE_TKIP_MIC, false, rx_info);
> +	ath12k_dp_rx_h_undecap(dp_pdev, msdu, HAL_ENCRYPT_TYPE_TKIP_MIC, false,
> +			       rx_info);
>  	return false;
>  }
>  
> 
> base-commit: ff49eba595df500e4ddccc593088c8a4ab5f2c27

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


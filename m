Return-Path: <linux-wireless+bounces-38882-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZD8tARV7UmpkQQMAu9opvQ
	(envelope-from <linux-wireless+bounces-38882-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 19:19:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E231742622
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 19:19:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=XyprIyLi;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=WY7tf6BH;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38882-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38882-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CAB2430089B9
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 17:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A0F280A56;
	Sat, 11 Jul 2026 17:19:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9041D7E41
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 17:19:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783790354; cv=none; b=WmwvCV5sWTbQK/TaD3YrIShU0VFP4v52fGZmbdPTAVCGetM9QI3g4xwBWYfE7wdP9lz9I7feNZcVHbOUzNZpiMoyvkc4JAN6BmV7uOsa5uGsTrLgnPraqIbpRIc3Ho481Svd01M6po7Rc5pJXj8HSjd4eSgNjnsMbytov4u5HMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783790354; c=relaxed/simple;
	bh=+9aF0d0kJ5Z6Db8lQF+nnWGjVzxBDPETVsEpKwCgCro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAYhJXdNJmOXaTihnf03UAA93b9JgtlBeJi6Sy/ZixZKZts7Zf2Km670Af/X7XNNpbDfee6cMrLFcU3UK8uiPtB8FAgmR+jg8LY+2oKnP8tiuCUbWvXOSmz9QX1wGLjFgncZr+j7D518i+yj5IuDdxvU52uLmrINpftiNLABd8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XyprIyLi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WY7tf6BH; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66BEOOIO3980583
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 17:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NDWt+yLeMp6nVEph2KabjKc/xug1a3uEZ8e5JaHfa5E=; b=XyprIyLiyMXY8+nn
	EYa/SHOLGsLJ3nBml8a3VHxvLGKRZJDdTbnaDsOHFHV3FcF4hQauBhkSzIfAL6nF
	TzE3FIXiPo3nbDmwC8m2ju1RHvxEQoVgYBt/7+5gvmlnGTXfZ2BDhSxnr3ktXDog
	ZQx/k3hoR51SdstS4UH2JxOHNyKeUPIoAp5M+tS4HIW2o2hywDIc35FnKUrlyGtC
	p+jtvoHPllGiphzklXk7Q2oaS8nYhOX0dKHYtDp2FBFva//Gsh+lk/Ug0joOUYjW
	siWCMX2bK2O7NDjWiEawulGEsh57JG9tprpFr0Y1YtatvzwM3VuX2h1iQWvd/YZX
	qgxbdw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbekch8kg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 17:19:12 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38db4fa2e25so1988940a91.1
        for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 10:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783790352; x=1784395152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NDWt+yLeMp6nVEph2KabjKc/xug1a3uEZ8e5JaHfa5E=;
        b=WY7tf6BHqQq9KPnEarznbA8TFt7W51Gbk/3G+aXtTSoykkJD9OV3NFPYO4EgfAb3uz
         KLeourUuWFwCNYCpSL43NofTvTkAG1N8Zaw6TlriRO4LzQhxP0qpVZdNEI6U3r8ST6JN
         bLmRyDNbvl6F2vCOHH+ajeJ8Xs5YlO/KMRvKi+BZMBmbCY9id7PQ3t/f0RwAGtgscVj0
         nxTQiFRGB8zcT36iuTGyqdEEzNg2j/DD8SNFrnhvjvXKqCuR+nAB3juP1iekWI+SPnWm
         Cf6PthbtKF1kSRPCQK/Etb3wbQl5wbX3NepUJDvw/2IGXIFVD3ww0uYaSoU03/VEIU5L
         bG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783790352; x=1784395152;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NDWt+yLeMp6nVEph2KabjKc/xug1a3uEZ8e5JaHfa5E=;
        b=PwL7eXD072N5nICBKp7zM3YHpsDZm/kwtJd2/+EOB4HWVYj+xDfA77FGax+ll3V/Py
         OgyEg7yEKl6nBzAbBe2CNiZOuTGjVLi6Z6vzd34FyDbt5PU4fmf5TdxFXg1sGS5dnmFt
         LBZhDAqnmejoARsu34o5aDFbv3a66SOGHkkMOBNjxf6ArNAlQ7/ScjMnJZPCPgJm27Bf
         bd3adUBhNM6QqCEnYd/8D6eaBcr7QR9P0vJOOmZNc0jBeaAGJEOw9pK4mrEjOtc7vRwt
         kYxMWZQmxKmHiIoCj1gLHPa9+VwaunOIc1IM8Fa9jAYhAZVHyEY3BngPBPLUAjlEAA3n
         POCg==
X-Forwarded-Encrypted: i=1; AHgh+RrUJRPutvaDIQ53bSU4s1ctOICsmSGhTy4BzQc/Av+YEFOlkyPaSnIvXXQWmK3+HnnWKKejX2Z527V8vlrujg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxByOT6FnmycDYCp3RFSe1jgwKmO7JtPUwmWA1TDB/uUqmIfmTe
	8vWWG9h82O42LHR5WgiwM5aHL6dPTOYJaQ3TrwBJVFgnQVXQ+fGwKl7o0wjMLfyOGOXrfV1AiJ+
	vLDe/AQK6By6XnG81IrEEAPGz9IgeEkuDHAhovOYNaK9+7YcgWHn6trrf2yjHuqTl4z5FaQ==
X-Gm-Gg: AfdE7ckc/alX+CAHPDGi3GWToEsr9L6FGhkoFsCCb6WLjiNmsePU3xGN0ALb0zpMoJv
	7JgNUZfDxsMpVwj0oKZVjERMWxtByqrDFz8oQ8Rv+vbNhA19PXbxzsalU1gLzS59nLTpDiYrMQo
	LCxRsoR8KWpOc8x4rseVaK7Dl+ZRdh6pXA1CLS4gbMn9fkKVD6i82npCukoETRqZv1C4F6h9f+P
	19SHfwWym170Xl+kChsxkXStoy8FYfIoRXGulpoZVPDbB3VeyKB5BPhO1wCw4EfN1W0BG7AbtTK
	ixNNygqmBy3yktCyj4CY2+3ItAb1Igf5+HeYCIiCSsHC5sHHunrUe/DkBGrsiQt4FJNBZrkwV+t
	IQTd9jYUtPtI5nG7mKZJLWljG5s7vutJK+gZa+D80+rbPGGumnU4RT7gxHBPNmqmm1kcw
X-Received: by 2002:a17:90b:2685:b0:380:9d0d:7af8 with SMTP id 98e67ed59e1d1-38dc7758d62mr3281606a91.20.1783790351902;
        Sat, 11 Jul 2026 10:19:11 -0700 (PDT)
X-Received: by 2002:a17:90b:2685:b0:380:9d0d:7af8 with SMTP id 98e67ed59e1d1-38dc7758d62mr3281584a91.20.1783790351474;
        Sat, 11 Jul 2026 10:19:11 -0700 (PDT)
Received: from [192.168.1.11] (15.sub-75-218-246.myvzw.com. [75.218.246.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311a6115e61sm33747406eec.22.2026.07.11.10.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 10:19:10 -0700 (PDT)
Message-ID: <b087521f-2130-44d1-b7de-caf58c7719e3@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 10:19:09 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k_pci: QCNFA765 connection failure with PREV_AUTH_NOT_VALID
 / "Secrets were required" state machine crash on Fedora 44
To: Nilesh Kumar <nileshcool@gmail.com>, linux-wireless@vger.kernel.org
Cc: ath11k@lists.infradead.org
References: <CA+=sdFznhv0RqfNaYYgpit3bqo1kvqDQT6CZta8=ZHPUXZE7zQ@mail.gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CA+=sdFznhv0RqfNaYYgpit3bqo1kvqDQT6CZta8=ZHPUXZE7zQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDE3NSBTYWx0ZWRfXyuuue7zjh93B
 Ixeu+DMN5RsnWKmqjabQH8O02HN+BrwRCR/Fneodehf7rUJR3ZoHe7r9oQkSrZ85hRNA5G01Sgt
 fWW3E1t9KCzV3xf+3bwYYfyf1c1KQj/2emk7p0a3SGCYJgwa0U3NGYdBsUS37Z5QSo0eOjeRNH9
 hNA49ooGv+hJFFl3XFObslRF1XdsKuubeOV0CNAD4V+C40as9Icqd0RK1IK+0jhsiYLidaCS2rF
 ZkcaYG4Ns2uZ2tYRbcIMWvJudGmAvVFBzM38175xC8X+KIUefqM6ufDiBLHODOOGNGOzOCZMDM9
 EivXA41z5vXBBqS/uat3B2py/ZT8D2zqKp/YHrlDVDtFxcdsHW6/4wMeMWzrp8KqswxkZYHMP8d
 XM++FYdrQur8uLPrabsJUsinukPrZX6mcWmpRmYqvmFrsV/odw+pHmD48mXWpPZ935gA+U5eZlr
 MzZzgeOHA2hDn2sSLBg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDE3NSBTYWx0ZWRfX5U1fVgqiYx/v
 nlf65OkHl4VLD5lEUMF8sPtCVbEFtmFmAlIZ7JnuCpi7qLP5j7g3HR8a9DOvG50QOyhfWX8XVPY
 lfphHrkHMN0wj1KxzYkxvPEaJNATfOY=
X-Proofpoint-GUID: ZRko608MiZ2q2DwiNqSNYGVPFf0DyA5L
X-Authority-Analysis: v=2.4 cv=XNsAjwhE c=1 sm=1 tr=0 ts=6a527b10 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6VQYfvmiyQ8t40WkS/mQdw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=-7qDptq3HqQkB5VKEdcA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: ZRko608MiZ2q2DwiNqSNYGVPFf0DyA5L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110175
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38882-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nileshcool@gmail.com,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E231742622

On 7/4/2026 4:55 AM, Nilesh Kumar wrote:
> Hello,
> 
> I am experiencing a persistent Wi-Fi disconnection issue on Fedora 44 that
> eventually locks up the driver state machine until a full system reboot. The
> network adapter is a Qualcomm QCNFA765 using the ath11k_pci driver.
> 
> - Distro: Fedora 44
> - Wireless Adapter: Qualcomm Technologies, Inc QCNFA765 [17cb:1103] (rev 01)
> - Subsystem: Lenovo Device [17aa:9309]
> - Driver: ath11k_pci
> 
> PROBLEM DESCRIPTION
> The interface disconnects after a few sessions. Once disconnected,
> NetworkManager and wpa_supplicant enter a state-machine loop where they are
> unable to re-associate, repeatedly throwing "Secrets were required, but not
> provided" errors, even when credentials are explicitly forced or provided via
> a passwd-file inline during 'nmcli c up'.
> Even after purging the connection profile, restarting NetworkManager/
> wpa_supplicant, and manually bringing the link up/down, the driver appears to
> remain in a glitched state where it refuses to pass the authentication keys to
> the AP. Only a full system restart resolves the condition temporarily.
> 
> RELEVANT LOG SNIPPETS
> logs generated are attached with the mail.
You should contact Fedora support for issues with their distribution.

If you can recreate this issue with the current mainline kernel then you can
submit a bug report using the guidance at:
https://wireless.docs.kernel.org/en/latest/en/users/drivers/ath11k/bugreport.html

/jeff


Return-Path: <linux-wireless+bounces-36406-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id A12GJy1XBWoIVQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36406-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 07:01:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FC353DCE9
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 07:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D59EC301F177
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 05:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6142FFDFC;
	Thu, 14 May 2026 05:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZWRTZd4R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fzr5b/cU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1443C2FE591
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 05:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778734889; cv=none; b=temhh2UCWwaA6JFoRb4df3/5i4EH8EqZuKhHT+5JcY1VPoxKf4ahBUSRJeMYwhfAfAGh6ak8Bm1DirsLeHJ8zl9PikrTlGr9JIWzT7/NtVAgOQ8F7cggN48FyfKIUQnbtdq8tir6oJj2+3/W7NJzQLJM4YHL83mtIJphpEWe53M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778734889; c=relaxed/simple;
	bh=jtnyYt4tHjxZRbd6mqXgg80h+t19/bApfesjshNIIHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SF4+Hn4p7LzwxvWgkdy6xmPkVN78f286FlUIrNfbyU/372sToi3Y6GXhDoIgPHBhACPzWycXf1ltombDTVaVV/J/XSFo/NgM6JZILeBhyODq8s1dEptkxSD2glh3kM272zq6uvWiH9b0GnDz6BYEtA6LZpU2xo1gUje63WyGtmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZWRTZd4R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fzr5b/cU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E35goL1096749
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 05:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TPM1o9fLzpUSz4NKGWQfQ2x73fQgq520PvfqDJfaOWw=; b=ZWRTZd4RqwNUakZ4
	f7j5ifoCHnOianH8WwuIEK4fwVUFS/AS/LHqhntYskT7655nXRyldcFBYPLdo/X3
	FhdzitY3HA1WHomkCrmcYMvl7W8X/Yblp9EelrU5DlJ1uaIuD5bV2vicbcJffxFF
	6jqfkrhvyqWluNP+hMtvYTIPFovPQSOj0Y+htNgzE6CTcZSfakdfnzzlesVML30/
	5ClgMOwnwUJ4HiXkbnZMZ3baCHKHpTEU++R3hF5SUGfY8lAkwAGclLAoPo0/+YnG
	e5eQ1vA4iUAu0XZV3gnh0Zvq8IXAQECF6vPulPCnlBlNujXLuLr0klEmetWSBOR4
	K2Vh7A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e566bga0q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 05:01:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bd6cc53fd6so116195ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 22:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778734886; x=1779339686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TPM1o9fLzpUSz4NKGWQfQ2x73fQgq520PvfqDJfaOWw=;
        b=Fzr5b/cUHy8YMnNVlviofxrv0oniTLDuGWDpX9bGz1/FXnnueFCYOW1oB5CZ6D2hdj
         M5sZ6bqhtQMWVdxS5MCu7QPy94rcu0/fXXt9IuW9rOAs2Qv/NEtjSO+YIT6JVplO9p3E
         jYDJuTDMON45Oodec8jxc+YizFWBEltjJSYiY7O31uPQLx27U8GG+2twALoBCBDj7uDt
         XF1Au3M3Rn8Kle70diERT9f+mtBqtVoy+z4sfyYcWGUezXBCRPQMcz3SZzQl9B/oIxpQ
         jIm1EzIetm/r7JCuUC7RLBFUl6z7d3rMhk1yVwXhb9YFIT11bnadcc0Bj9F7hc2wqdp/
         YNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778734886; x=1779339686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPM1o9fLzpUSz4NKGWQfQ2x73fQgq520PvfqDJfaOWw=;
        b=RNEi5omh8et6uVdWxxAnLTd+nyN1b8dMkrZfg2jNqrliLQi8PMy9KgTuYYwkCGJ9xy
         +FQqyzEybpoxbPrfxf/D8cDO7d+V6OEKsQYzFw2GueM7iUqTX4kF9KxzJzpZocBh2IQ3
         zhlUFj9quVDiRQ7NSp+g2bVT1V+fbAVvzUV/8kExH8HstcFU2iD+X4JYX+XSzENy2mJW
         mEuYxLQnTgvLcZBe+CM4fcjFj6Tu+bTcLNtuoBA2uRjRSCQWBkRzmFwP3Fsj+8n/gb3o
         zb+YsB/efYapcuUrqeTerz53sJh4lpT8CUlitWJl+X8PSkcf4vIlSsvDL3rEflQmGqJT
         sHig==
X-Gm-Message-State: AOJu0YxP5n41VMZUzpkLDcWtzPXBSmPy+TocpHjBg2vSaRuNOzW3xnpW
	lFKHl7Fsl0cp7rUZLA0RZ6fEPEDffPYJD5FIFC4Qg6B/LFCus4O0+w6MFMZBLGXZmIJ/btaeysl
	ISx/SvVvW4LROO8mWO5Txe9o9Ulj0+RI47Z3uMVe/gh+/1KZp2TKoHlXhAJYB/pOn8vjjrg==
X-Gm-Gg: Acq92OGxpYXJ+oV6XeKe58obtxWUJsnAdY9dj2XjfU+Je2tQnlC9IF0UoPlNVHcH2W4
	BqHecjtMRz7PCJVBu4Iov+T+NbXItz1eLMW4cuL9aJ8br8AuR8dXiUmuzbHseZ++LozkmEOdOLu
	9bwmWz27mMpbRaelJaIrRbgR/0Q0yf3skcUDl3KhVw2gS88qeq3XilXvlj9H9Ou6kfgy23hLm6k
	YtngviKkVx/q5VpNBUPPKckiezJZKUiUlWeVyhtwor4Jc+3QiF6Kn72UnEjlPQS++gxgwFq32yH
	S98g3bNxQtMgr7JMYxTvf3n0RgP0a5cPE8AAlD0Gah58gphirrKImNDCgPKqaaQD06RD/CAppcj
	3I+bgvdKU4qYC4XKgfShMk/K/Ui/7tN8b7ccs9LDwRKyeSaUdXOKlf5E5CyTxlw==
X-Received: by 2002:a17:902:ef0c:b0:2bc:db35:96c7 with SMTP id d9443c01a7336-2bd276dc126mr68369505ad.28.1778734885709;
        Wed, 13 May 2026 22:01:25 -0700 (PDT)
X-Received: by 2002:a17:902:ef0c:b0:2bc:db35:96c7 with SMTP id d9443c01a7336-2bd276dc126mr68369025ad.28.1778734885026;
        Wed, 13 May 2026 22:01:25 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d0fc80esm9432125ad.64.2026.05.13.22.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 22:01:24 -0700 (PDT)
Message-ID: <3683d8e1-5d53-47a1-84b2-7dcbb8ad20ff@oss.qualcomm.com>
Date: Thu, 14 May 2026 10:31:21 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 0/2] wifi: ath12k: Add support for handling
 incumbent signal interference in 6 GHz
To: Amith A <amith.a@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260511040242.1351792-1-amith.a@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260511040242.1351792-1-amith.a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: RH2AMQcREEA_aGJkTamKRne94D15T1za
X-Authority-Analysis: v=2.4 cv=WsMb99fv c=1 sm=1 tr=0 ts=6a055726 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=K02wEsJf6PS1E9QpTVUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA0NyBTYWx0ZWRfX5EJv1n7qCBTO
 VdnA9AEMQYLucZ8G5mKJ34T1C9t0eIo8l8LN+FhNv/UsM6RRqdGBeNYxBn3HhQaEN3Kqh9i8pKn
 G3ZqjE5SUx8k7QfpTMglFG9rMioDRV+wSEafD4dbA3Y7xsKB0FrH/M99AfccIOlRVKtQ6kV/+to
 OWvOVW4HzEBDjcB1j4ldWTru/cGA/zRNl3fsIT02hv482fFFX5zDDLD2zaNWjFLkP/ogO5A/fgz
 SgiVF5uBsPH+MVOCRhiAWlrZqOld4RZArSi+h1EZmdgHt8S0CLTebnp5Arq6uXZtJz15Nv9yYw3
 jq1ttY5cQrM/WEvl390zkqAtFCXRkeUgst8Z2U/eeEC+tsTVpBxkn/R4wt1Nh2gLdEQnzTkVO4x
 MZiAAmHQUPPUb814vyiSXYr0cogpOZnY6Y5Ow6GlX4pzBqiMvPSj79EDnZguLAENf09sttaadl6
 TAqRsmt+PU/jTJ/ADFA==
X-Proofpoint-GUID: RH2AMQcREEA_aGJkTamKRne94D15T1za
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140047
X-Rspamd-Queue-Id: 03FC353DCE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36406-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 5/11/2026 9:32 AM, Amith A wrote:
> This patch series adds the implementation of handling of interferences
> due to incumbent signals in 6 GHz channels. When an interference is
> detected, the firmware indicates it to the host using the
> WMI_DCS_INTERFERENCE_EVENT.
> 
> The driver is expected to parse the new WMI event to retrieve the
> interference information, validate the interference detected channel and
> bitmap, and indicate the interference to mac80211, which then notifies
> this interference to the userspace.
> ---
> Changes in v2:
>      - Added an explicit len check in sub-TLV parser before accessing info.
> ---
> Aishwarya R (2):
>    wifi: ath12k: Add support for handling incumbent signal interference
>      in 6 GHz
>    wifi: ath12k: Add debugfs support to simulate incumbent signal
>      interference
> 
>   drivers/net/wireless/ath/ath12k/core.h    |   8 +
>   drivers/net/wireless/ath/ath12k/debugfs.c |  46 +++
>   drivers/net/wireless/ath/ath12k/mac.c     |  46 +++
>   drivers/net/wireless/ath/ath12k/wmi.c     | 425 ++++++++++++++++++++++
>   drivers/net/wireless/ath/ath12k/wmi.h     |  72 +++-
>   5 files changed, 596 insertions(+), 1 deletion(-)
> 
> 
> base-commit: e12d2d3983acb150fd987d19ec6a2a530da110df


Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>



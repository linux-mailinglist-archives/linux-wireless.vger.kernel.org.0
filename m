Return-Path: <linux-wireless+bounces-31378-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJUWM43LfGnaOgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31378-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:17:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F399DBBF39
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D4DC33018D66
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 15:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF6737C0FC;
	Fri, 30 Jan 2026 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ok7QLn3J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H24kLdGg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794CA37F101
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769786144; cv=none; b=YCNmGOvafaE9ck2j/JSzLf2Cy6X4L9UzbbXxMtnRtfBWuU2YRH+ZHOE1jMJMNqWIEzPn+h14x6ERERCDrOKfntj7Ccr2+KnVBArG6z7MsaLIV/ShCVbJG31t6CMOEGqGqGj3YWvhoBo5w/NL/iaQUofUU+bV+YLsYlrWhuOOgJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769786144; c=relaxed/simple;
	bh=0reocHmCpaiY730goanavnYmc37iO4XO8eRO+iixfXM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TSF/A+YBCpUbmx54wqwV73ypRSfRGk0bxNgJjCQhO/RFpkXeywhkbkqEKxDxVY0QKVe3xFqt/5t+2mVO7JBMd+k/igiRCe2nTA3wfdV/joQTAxZ6HRvQW7d2bTVvUVQvW6TVqUEpjciF+gW2ftBFTqbyxW+676fb04PPcFwBHKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ok7QLn3J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H24kLdGg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UAHUg0995921
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 15:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BCj+sZ02Sa2PaRpZt20dwuF0yp5EkPLLEyveylPTWkQ=; b=Ok7QLn3J+zjRllv/
	k/ul6/s2z5hIiHtLZo62TSRON9kuZoUkcy169NPyj602JIPBeNArxsKm87PcInSx
	5JDPgnRUaThcHq4/QZ+NL7zkku9viCMocctFErupM6t52auhKmU3wj9v3ah7NT5q
	rR7i8AXCQOzeHfRNSDhAeLYuTqghM1aGCPtN3d53PH/eqJnEEpoUCuivcb9dKb6I
	pKKXGyE5ql1QUHPF6dZiTIR08WWqf1q923b+pTOWd0BCMkU69bFcBZmUk9o3nU8R
	ji138mQ3DMeiR/yDUEc7I0/UqwTylwx2cM2nawK//qalg9bOfsL9RCxN6MW1wob/
	SKratQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0bvvkke6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 15:15:42 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-11b94abc09dso3308189c88.1
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 07:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769786141; x=1770390941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCj+sZ02Sa2PaRpZt20dwuF0yp5EkPLLEyveylPTWkQ=;
        b=H24kLdGglqlxi70PemWlTzpt+vINAQYHF7o0vQLZTOcOn5ZVEU4VfBCc5PXn753GGD
         XJvqx4WM+aZQ9XNFgAlKkAw91v+iJGFZpaJByil2P0o1ZnldgdhITxhd0MTYFI7ylgl1
         rA1YHab6dsMZnzdGN5bfJleWiVZuHHQgwnH4enVQa212tAapnlzDyawu0VZ9PSp+JUaj
         CoZpmjNBudOxfZ+hcttlrtFA1p1mgTtGAQ1pg2kWz/isaltwgdzy3FAQpunLoFjRHdvP
         rYOKuRYPvqEW3kqancWZUnqr7uD/tI8q6Lx6AIcmcz3jujOhx5jtDIDyRNnxB0VFMeTa
         DPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769786141; x=1770390941;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BCj+sZ02Sa2PaRpZt20dwuF0yp5EkPLLEyveylPTWkQ=;
        b=G6VWXIJ7iT8CP52nK83FoSf15+IV0LifmxJalRmeEn2mKtREZZzcqud7VoQ4ZIqBQS
         jgeI/3WsuQeD7jXBpnJc7PLEZf8A6fNc9cXtm0lk4Him0F/BrC+AiPQ9/3s6KvfYvVIW
         NxcvIL1H351nXNtp2KD0N2KqzqkwkWjM2JK6wLa/EVFPODjshN6RjtSt5SPl4VJt0Wpe
         PyzUZcG6aWXvKBX9lfAEwTz+tD3S1Z+aOSSHr1rV2x+xUIActGRFr2861PmrU8DZi/VE
         rNPNpBqt3BW8hDz6AYsZ4KD7pcFXiShT2aiVusMrlj7GcAQUNN2UzuX63L4PnJy4ISF/
         IvVw==
X-Gm-Message-State: AOJu0YzA9Tz+xqtZExFQY2xWuFv0NBdx1/nXmPGTa7cosq/S6VKC24Vj
	DQmiwhrxuSgIQO9XWMGEfaQiFd9//1tXldQYoCmq2lUde9Fs2Huyyp5EJDxsjsh3iZmQVfIHna6
	StxeLyxxx4zzl8KUeUfAbPL4Iiz032bKvahzaHPyVhk0H1DjERK3zP06Un6Xp689nQKpDBioibv
	6Zeg==
X-Gm-Gg: AZuq6aJYT/O4F2YyjwTWneQWyTtvnUNs0Lni83efpp+CtsH23tEjyQlX5PjJ+2w9Ss0
	aIYuNXj4oEFYeBPDDl3qcsvMu5Z1ZTdG2bCZwTBDCx0teN1LbMs0eFAjHrk+S7OhtxsfN+1M8B4
	Ee5EYnW2/shXScH0GwDGgXyUxH+6B1C4buih+0M5xURwWxDxy1teUgEGYMZNDlubKi+3N/JBSlK
	iSQHw5tSLNOzSh4Krq84XBhIF6e4rDY3GVip6LGGYXQGrnzcEqOZw/OSFxLK055cI9DE7jY1qdP
	RJNU1gWRh+4UU1EOuY+Be4Ztv/BV+t2yEPgDLTJcyY/y6u6qRUSgFc+FmW49F8sukv5FdHzNFqu
	f4x78FgHRwWuNzcZ4aqGSwPP6bVFK3JDr3+70iGGHZgvW2g4gDmRl0ZjuY+OwHQQA
X-Received: by 2002:a05:7022:e98d:b0:11e:65b5:75ce with SMTP id a92af1059eb24-125c0f9ab5fmr1426122c88.10.1769786141035;
        Fri, 30 Jan 2026 07:15:41 -0800 (PST)
X-Received: by 2002:a05:7022:e98d:b0:11e:65b5:75ce with SMTP id a92af1059eb24-125c0f9ab5fmr1426099c88.10.1769786140338;
        Fri, 30 Jan 2026 07:15:40 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9d7f95asm10252849c88.7.2026.01.30.07.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 07:15:39 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260123071253.2202644-1-aaradhana.sahu@oss.qualcomm.com>
References: <20260123071253.2202644-1-aaradhana.sahu@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/3] wifi: ath12k: Add support for RX pdev TX
 hardware queue stats via HTT debugfs
Message-Id: <176978613962.3951544.11329608705566152802.b4-ty@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 07:15:39 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=ZdEQ98VA c=1 sm=1 tr=0 ts=697ccb1e cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: RuTV59faJZiaf6JA0nJ_zwF350txUQy9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyNSBTYWx0ZWRfX3WCpn4nCHDma
 9djuoLm1IVAUVeYZAGY8+iUbL4TVSjbVCPeZH7z854h6RmFf4kSuNj4ypZQdXylGR+V377G4Azo
 v/JnxMqmFW00NEN4iwxfj0mV8oLq0IhRF/BRe+v1ZHJiFXo7ILJuKCrhlL61RGKlaaRss40r5U/
 jR49A5LMY2vHVpy9XOeVGh5kGgb34+2CrkX7BkTFHAqvgFfOxLqsPRSkKT/xutatq9VsisBf8Dk
 VYIoElTxJZHnWc5FFYECOmqN4wRaYw/AoUirh7VHMrMJKUaDuQ5mkRTgTwo4uaK8rMmF0ZbLNUq
 ocUshUT7z+5DD3UdUbfiiokoOXHh1xxq44Kiv5H+Fs41TROK35fRm8P429UF9z0sV+3XL+oKZeR
 IAKdWgmUoWplkaYVKCE/U1/hMU0Vbb6EHpnUn9F/w4PO0IS1SssFC0UuK020/m7ewe9dSGEDQTb
 +2xY2qTJx8ceWj59ARw==
X-Proofpoint-ORIG-GUID: RuTV59faJZiaf6JA0nJ_zwF350txUQy9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300125
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
	TAGGED_FROM(0.00)[bounces-31378-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F399DBBF39
X-Rspamd-Action: no action


On Fri, 23 Jan 2026 12:42:50 +0530, Aaradhana Sahu wrote:
> Add support for HTT stats type 2 to report RX pdev firmware and HTT stats
> type 3 to report TX hardware queue stats. Also fix invalid buffer access.
> 
> Aaradhana Sahu (3):
>   wifi: ath12k: Fix index decrement when array_len is zero
>   wifi: ath12k: Add support RX PDEV stats
>   wifi: ath12k: Add support TX hardware queue stats
> 
> [...]

Applied, thanks!

[1/3] wifi: ath12k: Fix index decrement when array_len is zero
      commit: e4763898bb1325dbb3792961b6d607b5c6452d64
[2/3] wifi: ath12k: Add support RX PDEV stats
      commit: f20de310882d3c9b0a051b30dc39d0b640cc9cbc
[3/3] wifi: ath12k: Add support TX hardware queue stats
      commit: 05e810c8cffb3e96f6b967c9a57c34d4a6a6347e

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>



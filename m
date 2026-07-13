Return-Path: <linux-wireless+bounces-38978-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mmtuBbP1VGoGiAAAu9opvQ
	(envelope-from <linux-wireless+bounces-38978-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 16:26:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 049FA74C5CA
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 16:26:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=evl+KNZo;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=NRDEoHCq;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38978-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38978-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2AE48302D051
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 14:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DF943B481;
	Mon, 13 Jul 2026 14:06:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD9A43B3FD
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 14:06:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951562; cv=none; b=NOxsYgcMZqSelLIzbzoA2iYPWEw/uwG9xYUYqdy7Ou/HEQXon91trHKQxGZPGuRMVRekPN9RZSh7pED/rTYZmnjNlY2oqlEQZ/21vph11ZS8bTfbEMzNsbZqFS/E5PdB7ynEjoyX+kmIQFqsnn0bQQ/ksq2j714jUBKRTrVTpp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951562; c=relaxed/simple;
	bh=E4jKAifPqPOMJvgrOZSsMI+KSB9Szr5Y5kvefYu+3UQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b+/ZWJMvVtVK26cTDB1iAHyyhbto2bBy5Bcsy3v1AFSWDEn5rgcTEXxwQsCcVGpr+/bfbxYn5W0Wvz8QXzvPvC0i4Yc2kw+nPclswD2THnPbe3gFeYTbbyr96ubO8pDEeh34T6X/D4Ca4yu23Z04os+72YicW37TB+CNlqbEjiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=evl+KNZo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NRDEoHCq; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCDv7T1494363
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 14:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9AJ6tkAPs/hBDdoHJdUpYlk65CJplbktTv9X9/HcTe4=; b=evl+KNZowz+Oxmvk
	p8WxDqDRp6dmze2rBxPMdRgPnQ63B8SwEhkXC7YBE3clF7M9xBtbZw+9ZzYqKZvQ
	7jwNSu7A7oyUeDGSenZFchrmx5De7p+yUdDBUcPslrjbKWRtxPINL9AESK/ZIwki
	4I42Te2NrLzznWlKC/XTilyQylc+Pt3HYC2fLmGdFa+0Q7oYrYasWZ95K2f3bhzs
	C4w8zRXeLq4+M99tYStticI0PbEM3UnXbD1YvaY3RYToeY7TA9sVO1qoUqeSNF8X
	CetMUI4RiKXOJrFA9t72zLCIspxSm5AJ/QIeR6VYnIKzZcdOk/2lWBZssUlFMxjN
	7IPWmQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjnm2wtd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 14:06:00 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cab048cdb3eso2800359a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783951560; x=1784556360; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9AJ6tkAPs/hBDdoHJdUpYlk65CJplbktTv9X9/HcTe4=;
        b=NRDEoHCqlchu2lGTkSSYOtwXlquRfcDWY/dMF5Q2K9cr6voMKmkytPpMUO/s9bleJr
         mWUOn3fXqqgIDDCdXJk9cyUtuvc0K8ZI+zvNI5+y7mWSl6pQl5TJQyyAqX4cMAqwQWg9
         +FR1Fx5CNqJDWYhuCBhVRStdF3xAhXfMmMpjRcZZZT5o31dUrHCxUlzdaITkMi13swPQ
         LYHvaiHzsEqm3WN3V3YxLkddLRgCh3adGYi2qMWMMlkGFoQRbx8VZls5SjX6RciV+dXO
         gO0YjyOsX2BGrDJJyns3aLpdRFTrzRjT0bsdssLZ2ZG0kvlqHOTtGibSXDelb1Nwrill
         aQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951560; x=1784556360;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9AJ6tkAPs/hBDdoHJdUpYlk65CJplbktTv9X9/HcTe4=;
        b=qRnm0CXIpB2Qui415JhREkYESn84Hc8Rjx9sG90Vq8udAwZtCegHFHAIuc7Q0ZKhzJ
         Z4s4UHL6rimMzmQCkXGzyvBfVETfqNtM6ZVn/dyQ/Bg+UxWdUqUX6AS42OzPEn+yLhZW
         l3K77sY6ul3/AVKRjgCzVJDH8qsYAH76JtZ5spM3yN5eZLWrEeScHYtNzKgw31k2dmgL
         jTIcHWH/c4Y5pQehDdB5JjSw8VXV+mRYIHKP7IoZoD3XenxLzblI/QWS0zH2thdl6NwV
         d2oWw1n4zV4tDC6dnTVRRj5HhhMhC5FJ7BTFSBUoIcdySUnT7oGyfzDsB0cQ3UBnjKjt
         1/2A==
X-Forwarded-Encrypted: i=1; AHgh+Rrv5tk3gU2e022LyZ78P6r1Ej2vQHwDJ/eEkLjzvJv4L0j54c9gGcbGox7eb6NaVp5/j9C2KyqyGm1h2XjWEA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Co00gSuIyPDXKtThOxbej9XoW6+ghpAEQBEOmqmAX2eLF9Eu
	AZoQheDyD3O6u3/5g9T+i7jp7jQzKPjeyUS/3tkQqU2BVRmlMdXsrhPqGR7ycjuXkSdKdSbP8Mm
	xfT/KM1XwQP/vfEuqAT4eGXUqZ9bw5i2OLv3IY+ZYhryxLwUJ5nE0PNNIlKj0KMBTJD4qhA==
X-Gm-Gg: AfdE7clFKhBKHOrKEhYgGQTnQpzy9t9WxIG2p+f8r+C4vbCk2FSUyXpKE5t63BAqwNI
	yde/AkixmKaL/CDzCjOuUBgTspDikEErq7pw4vtbzQDY103+IaVlorfuWElHbxdM0Z7KLdvNj1U
	mtBrcXSCCRQrnOF+CbpzUKCOi0dAU2nANDfZfMWkKOegDFfdtm0XyVkyo+w/VQg80erYe07C0eQ
	JuCYN3uo21s1DCWFJY8+iEd/kd5gQwfQwqmx5DpPnjHb4/IMjTOCBJVhuyqyXmWyWVkKi8GEqDr
	cPzZB5bTW8MPudxPvVxUZnq2KxlUH7X39PPEmI7vbEZtzriR06vH1tEHytX+k0StZRcOu10lRQ5
	0/zM0+YGO5KAgPiqh0jicPPORLsGQSDs3MbbfuKrmQBHXBYTpiOoS5AIwJZtLhQ/c0g==
X-Received: by 2002:a05:6a20:d485:b0:3c0:9c1a:893b with SMTP id adf61e73a8af0-3c110f7bba1mr11791723637.67.1783951555199;
        Mon, 13 Jul 2026 07:05:55 -0700 (PDT)
X-Received: by 2002:a05:6a20:d485:b0:3c0:9c1a:893b with SMTP id adf61e73a8af0-3c110f7bba1mr11791681637.67.1783951554749;
        Mon, 13 Jul 2026 07:05:54 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm77071424eec.0.2026.07.13.07.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 07:05:52 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Christian Lamparter <chunkeey@googlemail.com>,
        Tristan Madani <tristmd@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tristan Madani <tristan@talencesecurity.com>
In-Reply-To: <20260421134929.325662-1-tristmd@gmail.com>
References: <20260421134929.325662-1-tristmd@gmail.com>
Subject: Re: [PATCH v3 0/3] wifi: carl9170: firmware trust boundary
 hardening
Message-Id: <178395155193.877545.10555494098180752041.b4-ty@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 07:05:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: OaKVciHt5ms3xeiam6LYAR8GcfjrKy7o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE0NiBTYWx0ZWRfX+yP7UxO3Vmg6
 zO2eOpITfoGH/pOOeRVAoSMZoO3BXw6PkYXEQ8DOMFEM6Li+wE0wUyr1GEnBetQ1IoyvwN33n+A
 M34VARYoR7mWPcPuIPIRM1xwHs+z6jPfwMq8P7p7jk58om4rQIvLdmVP7vBKuTo0nlx+ysn6bsZ
 FiBwX1wfGyeMDTHLj49KXI9CpJuDZKIwllrwYZPqVW1sKZUQZCGltlJMaQXv4D/6PikJMt6Lm6x
 kDF0jSugmlehacTyZ1Jb4F49Ha7Q1zhzmB7xkt9hh0YM2M7QWr+rmw7FNIBze2tGHlhVj81KljZ
 A23XHB2rNwyAx1e9rmLdX9EZ7p4+X+cQl/VeEBcjli+nzFlURscns1qhOfYeB6Jmw0+P2KWvYAd
 KBjqG8DhOIZUrPqwfzpm9LJPxWGHHvoKDMWGyDVa0vm4/MFQ7s1bDO7bM8i2do7PTaP2i1FRnir
 SXgAnWv/80jPudE4UGQ==
X-Proofpoint-GUID: OaKVciHt5ms3xeiam6LYAR8GcfjrKy7o
X-Authority-Analysis: v=2.4 cv=AfmB2XXG c=1 sm=1 tr=0 ts=6a54f0c8 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=J_-Nd1mkAAAA:8 a=EUspDBNiAAAA:8 a=gbkwWSGpafuMt5R-whIA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE0NiBTYWx0ZWRfX62nglDvBsl50
 t89XfdRMQIKG+X2bm5Yh5RVHnn+HwqOO744azlxUd2nGUuSXuvFfkK7alzKDJnpZEuo5masYAMc
 fwu/txzjtfp/KUVEqTt3GfQ2AT9PjLY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130146
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38978-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[googlemail.com,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:chunkeey@googlemail.com,m:tristmd@gmail.com,m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tristan@talencesecurity.com,m:chunkeey@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,talencesecurity.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 049FA74C5CA


On Tue, 21 Apr 2026 13:49:25 +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> This series adds missing bounds checks for firmware-controlled fields
> in the carl9170 USB driver.
> 
> Patch 1 bounds the cmd callback memcpy to prevent heap overflow from
> an oversized firmware response. Patch 2 fixes an off-by-two in the TX
> status handler. Patch 3 caps the failover copy to rx_failover_missing
> bytes, using min_t per Christian Lamparter.
> 
> [...]

Applied, thanks!

[1/3] wifi: carl9170: bound memcpy length in cmd callback to prevent OOB read
      commit: 4cde55b2feff9504d1f993ab80e84e7ccb62791c
[2/3] wifi: carl9170: fix OOB read from off-by-two in TX status handler
      commit: a3f42f1049ad80c65560d2b078ad426c3134f78d
[3/3] wifi: carl9170: fix buffer overflow in rx_stream failover path
      commit: a1a21995c2e1cc2ca6b2226cfe4f5f018370182a

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>



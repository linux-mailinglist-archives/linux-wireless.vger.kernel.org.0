Return-Path: <linux-wireless+bounces-32359-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cARwG5cFpmmzIwAAu9opvQ
	(envelope-from <linux-wireless+bounces-32359-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 22:48:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E0B1E40A3
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 22:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 269A83323A8A
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 21:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AAE39D6F9;
	Mon,  2 Mar 2026 21:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OtgISUot";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GT1VLusk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59EE39A069
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 21:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772485658; cv=none; b=lwHRKTAs9slpE+L0bc0kjxKMIRCqMNc+LIDrx5l8HRWEkuB2rM3Nf19nwZxbjkzkxp3K05raA3qQHo2zSD9TP50UsgmpwvT2kECJVdgUzS1jS/GRN6sW/wcSsfU0PkalCinBfZf9PG27kFbjBmZhqI1UHtIR25NyRWvB45W9pGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772485658; c=relaxed/simple;
	bh=OEqMySFWSnZjKiCWuO5Z1F+9mpxMB7qWF3Nrb8IkC24=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E865kS+bWPq+q0XwXpr6AAu6621s3aTHU2V3onSUWOYkyZFE0S1lBlZkRUVY4e38gnezTp21u+l+A42vnNLKKPYoUYlcW0sMxthbwYJhtYz/gcv4r/pgX208WW7/DhmMV6MSqSClzeAjilF62CeE2gVlP8nHgNxHEtY/JnppftU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OtgISUot; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GT1VLusk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622GFria3752705
	for <linux-wireless@vger.kernel.org>; Mon, 2 Mar 2026 21:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J96wQHk10XbuuGaKip9JcOJCisie4ggrztVEg1mYn2Q=; b=OtgISUotKfshvwFK
	2Nym3G6CR1xXbvVebc3xIJsxxitleo81vdVAgV/3Kj8txPo5JewV1Y+abDWe7B53
	9rmPDvGLBEAxa77v+JBM0dk4JYfdkJvrRQXXSWp2F8KfEH6nX4YKxL5c9VJ6QL/X
	91h8NGKntiUY8Kn2+eiTeDNLT2rGeXxvp3I9sp9iwwUGi05lHKgIssZUY8EaOPKP
	jt/Z8qHV7l3EdcX6iU7pBdogIAQfZ853dTPfTc9VyLwpHt0mmgn1ISG3BUbFplel
	4OM7G7+cn0FU0vlk06UqecWW6+vjQmmAGBf4CSZvvDVrMnO+Wy032ZBQRL3b5YP4
	eXgcDw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn7kqadst-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2026 21:07:36 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d4c6bb79a5so24845529a34.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2026 13:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772485656; x=1773090456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J96wQHk10XbuuGaKip9JcOJCisie4ggrztVEg1mYn2Q=;
        b=GT1VLusk2ORgDmnLoNkhfI5KLTh/zkO3/PV+wQm3VvvkVLgit43jSxfpIXacmhFlum
         +aWhuuCpuWmwSXXVgpITDszSfozWQNBgjO9wWO1qIkYRQW3w5iVD+sksXZeMfq2TkmuU
         oxfRLixtc6/fmZPKNCuxiUzwDseNo+9K4Vyq+ggSXDcP2Gf7SxhpoHHcFek3HslTWtmJ
         CCZSajKeW6qvPVXXSFD4Vz3QtgNLbvzhnxB95QBv5wCpEowVIXk4sm6QeswVS+c0p8m1
         Dzpi1ZM74We4JoIh8jf8km/JWzOIkkkAsGMWbL9tMr1XAaqjqaPhkiEphi9kRT+fZWSw
         XIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772485656; x=1773090456;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J96wQHk10XbuuGaKip9JcOJCisie4ggrztVEg1mYn2Q=;
        b=OFiL12Pl7/BFFRPsLFnAPO8zwRBNBzBOhsHvKgp4PdR53xqqXTvpy8OlHUNdaqSvAa
         n61MRoKcj5G/mHHA9+VrKHMcVtZsNiMo+eHNeJ/oP4q6G71ocf19shS+taT/sPn/Mnzl
         VjTXIsJOgK521a5JVgZ3A1B3kkQZpVRHA4pjrY7jHJ2hKqpfSU9MWvQjIjR1V4SWrB0L
         jrjlytY0WHXT93FcWikNP/W6YLckUqIBwI+NB35gvWgZqy2Rj9grzFNPRDFSt5GfxKBS
         b9yvpxnyCb4ubBW0x/T2mzf2m+XS4zqyXNwwB+q2bJrhwCcfECYRm21aYYkWvvz+nDTB
         OMAA==
X-Gm-Message-State: AOJu0YwBzvx6tJbKHEW8//xd/GDsBMi24WNpNWMBxFB1sQawJilmirGl
	iX5Vknwqjn5f+OuVdwQZLO/MBEf7ILH0IBIgov/cXqfIx1pCX3c7P/CvOS7Uke/Tk82+Vk1tBHo
	ByJ1S1GNLa1eUxIeR6HF++lKWtcwMbPJ3wsOifkPARj34oFfuiaWyA/kzRXJ5z1TvclL3PQ==
X-Gm-Gg: ATEYQzwnywgppUu0mJod9PyI+Ym2oaXYV30Vt4V4WlT+VQUyhRJKy3TqeiqcUIPzcA7
	O547KUP2lq/33ZSPCUowetue8lw1I07KUu0lpEYYM+yHS1g3FZQd+26GLD9aCXsaP5MxAFonHM5
	e5Bzuk9/DWEpXwPVP5NLLZvXFQOKW1u6qoglSjVt4v+NJrCC7A+UYYS+bFPAW9MJoklo7GltCa6
	lWuXREjikGDUsv6lkFdD1kPnmga8YU6pDLD/Spb1GSU0/l3RgOGAktV/C1WrwBsA5n5m/5igGSk
	tFuiAfJL/IeoGpPeNov7DhlpVbBoVefLK2kXgaUONghLKrKXIO5wp/zlhFW6fk2tIcJxkfO06K5
	e4+PuJkq7oEcP8auM4WWxEjiWtUR+z3lcGiDLCsLbxKPsrhniBHXEv7oMvi7VrgiN06nH+vUQrq
	aI
X-Received: by 2002:a05:6830:64c9:b0:7cf:e3f3:412 with SMTP id 46e09a7af769-7d591bdc2famr7857184a34.24.1772485656006;
        Mon, 02 Mar 2026 13:07:36 -0800 (PST)
X-Received: by 2002:a05:6830:64c9:b0:7cf:e3f3:412 with SMTP id 46e09a7af769-7d591bdc2famr7857170a34.24.1772485655633;
        Mon, 02 Mar 2026 13:07:35 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d5998bc31asm7449967a34.23.2026.03.02.13.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 13:07:35 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260227033332.687805-1-aaradhana.sahu@oss.qualcomm.com>
References: <20260227033332.687805-1-aaradhana.sahu@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Enable monitor mode support on
 IPQ5332
Message-Id: <177248565484.1002715.11144133225824646207.b4-ty@oss.qualcomm.com>
Date: Mon, 02 Mar 2026 13:07:34 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: WbQpKYa4lf7Ok8NvkpLGflr0eHrjxWaB
X-Proofpoint-GUID: WbQpKYa4lf7Ok8NvkpLGflr0eHrjxWaB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE2MCBTYWx0ZWRfX/AjAZ68q5jpB
 7Gzyila6gfKMMJ/g7iiYeb/JxeUGwYRDvTxz7fEtKhA7L5qjqgIJwMBjIGjBsKHwmLcaD9/pX41
 HDhLZu378llmb26upE2Hpr7UyRXua3L5ndIVWWCnsZqOW91t/hUjeIortIDkcgxMX6kWxPGHOP5
 m1XdTKaaIl76gRkzAf0YbwQ35fVVxPOdtbYnP/L4tnaXgwR5iti8D6WH5AS/t4qprvquxxDaaTe
 dV1gJIAbn1n1TngFWG1VVkLEZhsgi+YcSoBtMZQm5G6D8r1e0jQXdoh9Lu1pa8R/XYj4KMnJJ5S
 p4oYKQvyD8n06j16OHFvfcj7dqO8E9tKSSBtgYMRpqsSDihO7I0ywobEHFGFIZxIy9QLdD3112j
 qyQxZfAquqOUSjcYUF2NrZO4YKh1EEBhnTpjOKj4W6cBjDg/7X5MxM0WQxfa881e2M31EQaeIwn
 OA6WpsOGFSEDtqXSGCw==
X-Authority-Analysis: v=2.4 cv=GLkF0+NK c=1 sm=1 tr=0 ts=69a5fc18 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=pVW9SppbS6E-DvIT1F8A:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020160
X-Rspamd-Queue-Id: C0E0B1E40A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32359-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Fri, 27 Feb 2026 09:03:32 +0530, Aaradhana Sahu wrote:
> Currently, rxdma1_enable and supports_monitor are set to false in
> IPQ5332 hardware parameters, which skips monitor ring configuration
> and removes NL80211_IFTYPE_MONITOR from the supported interface modes.
> 
> Set rxdma1_enable and supports_monitor to true so that monitor rings are
> configured and monitor mode is enabled on IPQ5332.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Enable monitor mode support on IPQ5332
      commit: 80a1147469b07a384f6f83a26b31bcd63d6684c0

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>



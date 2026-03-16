Return-Path: <linux-wireless+bounces-33303-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKq0BPUkuGmNZgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33303-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 16:42:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A829429CA23
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 16:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8CFC93035BF6
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 15:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A2B318BB8;
	Mon, 16 Mar 2026 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KZznSQ+A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c7xsuMKa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0351839F19A
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675475; cv=none; b=C2C88kpHUscBxA+5jOgaGrOrSnVzaKpUxtzGo7UMrUSsK+M+r4xcRVi+bJah8xJgW0efBNcQKSU5XMkLomA+sUJ9LpqOaqIlAJfM4aY7apxPQbVz8SwETJ6r+1A1mIldovSUOCL5qDMujiqfj7/cYhByV2dlrEjdxqDD6c2SdqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675475; c=relaxed/simple;
	bh=W5RQ0rSQ1cER5Kem6S7/XvJmhqQcpSEkHt0D3uupKkk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Bu/aFu2UNk+Pz29x6fyGpLIZzuHsX7Xf5pzldE8bUXjow4tCgpyHk68fGAC3ySIfPdTiZ7iEulosUnHqVzLbQx/eCDuGsDIEQbibszvUs12N9Ae9uCWLVQTyHU0hvlOZLTbIk7V7r58F52FAXAwVLoFRlKkGhpl60Lvu+5BUccM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KZznSQ+A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c7xsuMKa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GF2foh1534032
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 15:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	orItFT0VanSbWworpG3j7AcsBcqCgT07fq6tPteihX4=; b=KZznSQ+AXxSjugau
	FgklzUV8L8fB/jmXzK8m8sIs8dd0ibBI5mdW/u4lT0qONkPAcelkYUoGKtfrkiTM
	1DG8A7dl+xexYumhHO1n9XHjy2jtnKhVhlsLIODLEmaPbpLxbHwH6KVxtNw65dhF
	sP3A4JgnnVSwGY4Ma1E/3+SVbFH3XoVGy/8eHpyWYS9rZrQDpRtiM9RIoe3+fg/8
	AqMAp78m2bPMZyLNOxvQEwq08uivgoDTmbjUM2C773BYnMtta1wzPH6RHYSD8cgm
	RDxiTv5NCyLvPVXSaFo9ViKjiItszD8KV18SkXNJM4fbC5mixl7dvnjHOvj7AyRC
	9JChpg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxm5k048c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 15:37:52 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2c0ba59a830so1359107eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 08:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773675472; x=1774280272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orItFT0VanSbWworpG3j7AcsBcqCgT07fq6tPteihX4=;
        b=c7xsuMKaT5fwG+t7nyPP79BuO75eIDvjOXYi7KwLo4kVej3Jn3dnkCFAeL5n3ZsM2+
         IRpaFQmI3Lkox81PJjRov05USVl26F/UPhZq+LxVnOS+3oMd8Xi6nvVC3oY6Z3Fo8Jhq
         kUVAzlppIogG6c4JMxH4jFbrmWU89oCMbR5WQ63OPp7iKQW8p7njkBV3d4RwxUS+gAWV
         8Tpaj2fzW0IxeB/XD2/02vn5xswdtbPpFAB2Haq+MFi4Z+Q6EAdIv6zXavZzGU6e4OuF
         /MonJOqsYe22+cEcSBuBl/SEF1naaRrfXHM1pEcYkAybm6H0mlKl3/x/4aFAnJZ9yA1u
         v8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773675472; x=1774280272;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=orItFT0VanSbWworpG3j7AcsBcqCgT07fq6tPteihX4=;
        b=tCpvMHMDWOdYeSkBAnpmoC7sdpXhNZmI5+OqYZr3dW6vl+NJJJKkkBUriAlwmBGVcy
         hdRhkuBrHYvsTEO0zda3r1hv+p6nLqYf9S/WIbavfrXUqfMc13o8j/ABsbiIDwh3R+ES
         Q3+9MmwzHq2Fxrt9mdHFrqFKCxliZqVVKz8dRNEb1zJBJ4EQguHkqICzH1AwvJCMc6o7
         5aS+HNQ9t2NqMuorOwWxwgMScTGqK0thH4aajitMcNbeQ4KMNHBXWkSwxeOWwkfTTRyP
         62M8WXjnFUJf/9Ad/IfbbBhwnVxa4KbPuLiFhINNBWJP3tgilUexFNyIn5ANuSS+8B2M
         N8zQ==
X-Gm-Message-State: AOJu0YwCSME+Ahp6USHfMpUBLPlAwZVyZtGmFQAEO9+9+MWuDQ43248S
	YWRNd8RGtp66m7R6+m6bOg9Ap4coDvJjlzIZs/8JJyfTQir3FGFnz0jqlXV8KFqOi8oCIE5XGtn
	BDPhITY1SVDLtMaMOl5fqV4PuCkqzRUEbnni7jxZrIOqj9Edyp1fzsfhGGZARBuMl08xvGA==
X-Gm-Gg: ATEYQzyJuzJjzqPa29tnAd/FUZX0QFi2SR7lgQ758yTTyw20M9sAn5yCU52JqZR+ArR
	W8vxVHRECobo1O0FaYFSHqZNByM9aH+B1eKzLVP1UU5lGfOPD80tik9u0DQ/HiqmiWqtFZ+OdSY
	SWbRQwyxrTjClfPbDH/HZ+vrldFpZi68Gp4wlNiqggleDwMyEENtW6amNmmx3dGZi7qUgRMl6Lo
	OPKPETYZ9ifrCCQ43ri4eH+8DpXTUKo7o6FO0ZGs0Z68RSzQypyrQjY7PypQsrjndlZVgh11+vL
	C6l8jM7jHaWgCpm8ghPyVxW14cM5t42BPwNfPJd+In6AypXJntX0quH8XDfEtaIrUdpJ8grwR4N
	gkiBDxJ9s0JQ4BnWHBZPvAtlQDev73qGL9a+IjTSJ6uGh1HAY1B7KpAKWDTuQqVARdsMZ+r5MfE
	Os
X-Received: by 2002:a05:7301:290e:b0:2be:79a:69ef with SMTP id 5a478bee46e88-2bea54eed35mr5930939eec.20.1773675471896;
        Mon, 16 Mar 2026 08:37:51 -0700 (PDT)
X-Received: by 2002:a05:7301:290e:b0:2be:79a:69ef with SMTP id 5a478bee46e88-2bea54eed35mr5930924eec.20.1773675471215;
        Mon, 16 Mar 2026 08:37:51 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab5706bdsm17695739eec.28.2026.03.16.08.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:37:50 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260310-ath12k-unit-test-cleanup-v1-0-03e3df56f903@oss.qualcomm.com>
References: <20260310-ath12k-unit-test-cleanup-v1-0-03e3df56f903@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: Clean up the WMI Unit Test
 functionality
Message-Id: <177367547024.3157544.3506464317798328713.b4-ty@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 08:37:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=fJ00HJae c=1 sm=1 tr=0 ts=69b823d0 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=dOMWL1FOFzDKkvFCTc4A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDExOCBTYWx0ZWRfX3DGJ8tjs21Bj
 eGi8k5F/ft40vMj1fwaWxtPfYuv8/PrIASi1+4LNOxOxLZNf2g452dm7g8+pBeV+Hak9OlavoRP
 hVrYdBOBBBI8QDYvvIrupc4oP8Ko8bYfhg/iILa2nxdywvQjSc/gCsHpf4VXqaItlN53S+chwxu
 iy90jVuxizSQ6mcEZO6lNMUIhSLij7UI+NkAzSn+OELTLADlbcwSOUhb0rr9OpDgJooRTU6XyrW
 hY4hBEnUxePt11KrkXwx4TNawlr6msYyOOiAY/zT/fFnUOoiOKsZAC2E7m4y5vc0AqF2mW6THzL
 0I+Z4I8xEqwzBBXLZS4kkvlkKta8KsXxHu/X/B5g0ccgmhj7mqeG3ll2ss2s8HtwNl010+Fv3A9
 kWCc62Akfd+UiY91stXH233+2osGm/EFkEpH3eS0r25W0tiivYPesS3BD2baHhQ0DtLLdmRue2E
 2X9vVdwuw+C/AvkAp7A==
X-Proofpoint-GUID: b8TxkCpWeoE1ymlGTftACjPMVDLr9U_-
X-Proofpoint-ORIG-GUID: b8TxkCpWeoE1ymlGTftACjPMVDLr9U_-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160118
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33303-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A829429CA23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 10 Mar 2026 08:16:11 -0700, Jeff Johnson wrote:
> Patch 1 updates the core Unit Test functionality to address multiple
> existing issues, and patch 2 removes unused DFS Unit Test definitions.
> 

Applied, thanks!

[1/2] wifi: ath12k: Clean up the WMI Unit Test command interface
      commit: e570593b568f74b8d8367d094400d71bc398118f
[2/2] wifi: ath12k: Remove unused DFS Unit Test definitions
      commit: 7bbb578fc43e7dcb8690cfc98844bd67bc311e8a

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>



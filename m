Return-Path: <linux-wireless+bounces-35866-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFGFG7er+GnHxgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35866-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 16:22:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E26AD4BF3C2
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 16:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFB8430297A6
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 14:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7890A3D8129;
	Mon,  4 May 2026 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QEq8k//7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jCRFPUNR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD403DE443
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904478; cv=none; b=GkfP1RYf1gHpLjT7zhB1fzAx3EsMa48jXn6yed1RbvkljodA7uXz7oNZxlHrO/WVnLlJmTVyrR7mN2E3o+bJ2vCx8D9mINn/ofSioPSI0irwQK7+OFlyu99+9p0RxzQOGQv+fdyfXx9FxviqTgZxNddN7UkEZQ0loDxet0AXGDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904478; c=relaxed/simple;
	bh=IBZMVw9noHc6O7bTWIkUERfK5ZxmQoeASZ2rtxmDPq0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d1irGlEr+VYB8365lLKe4muYf4xaSjX/0sFbQFDoFVzLyeeCAl54QwDnJ6kxJU6hHf/4nkF7cZCjwIh7W3KiszvRZRmUZtehqMLAKfYxaMXsgM6f1H3mXKi1IvYP4DtUXf2l6ch0ThF6LrDZXJ5o9bqgN/eBTR55Uub5AvBGDyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QEq8k//7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jCRFPUNR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644B4Ihh749360
	for <linux-wireless@vger.kernel.org>; Mon, 4 May 2026 14:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xI1oH0A4Gmbi+vXczhFtUqnJwavLiVD+sTVtQ3oOdBE=; b=QEq8k//7Bf5Qbvr4
	ejhoH5rg3YorG8Zr0OtO8IHBSeBCKCzGg7pfChR5viweStmS0lgfZwJOptJVbmo1
	OJjI/97AoWoGel3AVXrIPOMLm46Z8IYl/6ayW4gFCtlP7B144GhbsZWyzyIWeMUW
	4Jnv8hagvHyYO//wP9GA6xlE30bzUywKrP8LdC19L4Oir0XjNrhz1vXR/h9kl9x4
	2VKjqxxW9bI5/cr9hxr9+Uqmz3cLj95f4n0OqAryVzQT8O5/PvEI8GVEKRKLGDtO
	uGRY20axQahHXaUNnjA9dDhwURMW+9ED/ZIKzlfyv3weSBCEBGSVd5WQ3DgRladz
	EJ8v0g==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxscf0rnq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 14:21:15 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-12c8ccc7593so4119919c88.1
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 07:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777904475; x=1778509275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xI1oH0A4Gmbi+vXczhFtUqnJwavLiVD+sTVtQ3oOdBE=;
        b=jCRFPUNRvOGjyBqyzg3olMhyj+yZ5kdMHjfP7hH0vPfZwrB/8qmIcIv/Wf1rzKtJhC
         l51LnLMZggxjjbjZgn3QDw52UGhN5GJvUFa893YJbaRKfkFl7RlnGnfuWcuC4P4rAAMu
         F+4sVjAgdWQ0XgHaC7wNswMhi3okFtgIqX4gdLdifkWofVTjCUYGyZ7ofEP8d5wO4b5w
         PdMejIAjxrS90+cIIYz/YaWWQbUN88YsRES/CnAdmcozHUwjqrG7hregyO5O1StIUjuw
         AIk0q4M28U5jPnPmHeO3M8qYHXtSZYhmcTlOFwISPtzWSlDuGmkEtXHhvzuAHyANaJSb
         sPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777904475; x=1778509275;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xI1oH0A4Gmbi+vXczhFtUqnJwavLiVD+sTVtQ3oOdBE=;
        b=CCyMMMC7Ce+vEMZ6f2PGv8QcdJGAEjr9JXfWLWkqVbXkiuhlA/gehTmK5SekbK6Esj
         sqc/zzH/+ZIClJkuXVyXQCRNuobYmemK9HnVCM2rXnhR3TKWrEH44zWd3wPE/S2eohIi
         U9VwdIRs8LBJ5tdkWP8iwnKHhZk7BDjY7DzVkyGnZebLsC6jVM3lwCilfOLUf5Sa4N86
         YSftLCao1hP6UNkH84Eaci80WATB6BckAKfZthV23tHXkbskjsw1c65Lg8SkzDm8IB9O
         DepcMTw3nqddL3eWqs93Bo4DUjvX/vQl3s6I0z9rMjlN+GzQAfTOZuKjq0RJK5WUJWby
         lwIQ==
X-Gm-Message-State: AOJu0YxDhOczKuMnLgzai8KlXpre9vZmdN6YTK1A2Ecd3XcS6i3OBPrw
	fZJnqcQG2Wkfs9oLSdNCSl6YHKS8PtofQtSs08405nVsUyWavo7Hxq2ZUEsVhaXBsk+A8oCjrfD
	UXvWMdGqGNLAALwYU7YzRcdDenOn6ZprZzmYA1RlO2CejL/xSJrRugWQr4vGwHAf1qUGU1p3L4R
	4hBA==
X-Gm-Gg: AeBDietdiZBHRz4lspr+01kNWXP8twvixC4dv3H3coMMaAfddKkSxm0rD7l06H46WzG
	O7m6Bj9ycw6G7PiyeO52TbJh8P/P0tgz4XYLstBfJK/pIJ/GcTLCWCGEBz1BMQHfdWtVP4Owk6r
	jdyTIbv95zaySGb/fnmgBLynXfxmGWSFhqN02P8LbeRJB+kSeZZB5qZqhQeO2k+s4oDxuK1YVBn
	YNgbzg+qIfbJ1KOLQDra8uRRPHEnQMPm5j6dEBOkIaDVnwMenFCNqXvsY9qFIL/BWYrQCFTD/An
	bhE5bNJldwZsPiU+d/U+ZYWO3GN7UvrNfMTBZrxPLVn2BF9+B7upKsqcowHsL5QDXN5lxsAGgao
	hGDu7bfr9VVoBYm/rFsVKG6yCcJzo6oUhCcMYrll9flAb580IKmg1vghXcm7gH+TPIwbUy6uosn
	eP52tWAxHWTfg=
X-Received: by 2002:a05:7022:6628:b0:12d:e539:98e0 with SMTP id a92af1059eb24-12dfd846ea8mr4341839c88.39.1777904474344;
        Mon, 04 May 2026 07:21:14 -0700 (PDT)
X-Received: by 2002:a05:7022:6628:b0:12d:e539:98e0 with SMTP id a92af1059eb24-12dfd846ea8mr4341821c88.39.1777904473731;
        Mon, 04 May 2026 07:21:13 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df8452edesm16546186c88.14.2026.05.04.07.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:21:12 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Nicolas Escande <nico.escande@gmail.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260422163258.3013872-1-nico.escande@gmail.com>
References: <20260422163258.3013872-1-nico.escande@gmail.com>
Subject: Re: [PATCH ath] wifi: ath12k: fix leak in some ath12k_wmi_xxx()
 functions
Message-Id: <177790447285.1253723.863841301570135163.b4-ty@oss.qualcomm.com>
Date: Mon, 04 May 2026 07:21:12 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=BcvoFLt2 c=1 sm=1 tr=0 ts=69f8ab5b cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=tJU9ox1lp4qBWCJDgPMA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE0OSBTYWx0ZWRfX3Y7iOf4fyexx
 K+JatawZXYbAcztlEI7FThiggXcwdaxvMOQgkmXkt4wuC2z2sJhN+h3tmCbIjD4xG61uvaw3wXF
 /xEgOJ4Uf/6FLIa34BXBBjRY0HavESENEvClAZJIEed6y1PHROKFJbfk/W+HGjJ8AprL9Q8KuYL
 Uao1c9pUMDDRLtNjFItVXFTjm6V3eYag2iFI2QqI8TQ6iNM0yVzvavQ8yr0TyhZ59BuRkoC3uf9
 8hvD2kN8HGZ9KMoSvOCAjU9uy4j7gkOw9zhaPQ3OdgN318FYBWgN2djgSydcAb9RffFJj2TJsOo
 fec4lxdT4Qw7oShjPjs/6JEKW86dBZeoAXaO24pPbcYcUdeCkrtKC++AoNZP3ZkmOfppjcAxOH7
 y+YEzzylan4859kXtafzlZ42Uvi7rE/nk0kxvFex9pA870Qkhu1MxBgdZTBXUf8orybt+ulWMG6
 +r5lu1VM0mP5L+YTvfA==
X-Proofpoint-ORIG-GUID: NupJSw8zUNOx6AKQm1PwyXHQs19FGKY7
X-Proofpoint-GUID: NupJSw8zUNOx6AKQm1PwyXHQs19FGKY7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040149
X-Rspamd-Queue-Id: E26AD4BF3C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35866-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lists.infradead.org,gmail.com];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]


On Wed, 22 Apr 2026 18:32:58 +0200, Nicolas Escande wrote:
> Some wmi functions were using plain 'return ath12k_wmi_cmd_send(...)'
> without explicitly handling the error code. This leads to leaking the skb
> in case of error.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix leak in some ath12k_wmi_xxx() functions
      commit: 05c5078de822148e7cb84968a8783ddfcb6c9ef1

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>



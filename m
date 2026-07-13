Return-Path: <linux-wireless+bounces-38974-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wloDGQL4VGqviAAAu9opvQ
	(envelope-from <linux-wireless+bounces-38974-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 16:36:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD0674C787
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 16:36:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="WOQPMnj/";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=FezDkst6;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38974-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38974-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BDD93046115
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 14:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0072E438012;
	Mon, 13 Jul 2026 14:05:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBF9437472
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 14:05:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951548; cv=none; b=LA6ILomIToeGP+54sqUT40JDwMLS3wMsRVD6SKO0vq+yHDpE3Mbm7OhbM/iXwh+u9rksXj9gTqArlhxq+AHXsQPhH2GnVzcsQoCu597d8ujEO6CiCbxW7CFicVXdyZxJ7Px/HPpBLhFJwNu41l5amvb4eyMXjOqX2nLmO1rWFpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951548; c=relaxed/simple;
	bh=DXjFWbsezh9XQd3Y5ft7S8+bsLXvl3CKO/w33wcKI2Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hSk88vU3kuYlyjSVzFuGh6FLpZqcCNS/7Ys8ihr5uZK3k3El550hDqSSoKQO6neEEqss5fGzXz6ONNo+b8SJ+H5CI025UJ7sEKsJgkz9h5wPgYvu8jA/fg2KziSn8zVTbNYUaELYbCnyPUgTJ/Yg7haOx6fe0rt1lyutd/rmiSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WOQPMnj/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FezDkst6; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCEMji1333544
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 14:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vonu41nazZKgZgFzgiMlMdUi1Svr1anpCHuYLg93am0=; b=WOQPMnj/u78/0Gu4
	LIUId8l6vhHd1IqKI6bV+dVRsUyAGlc4lFE2RFB0/T4N7NBJaKdIesmQeyoDs/my
	pFmRqgz6AYrzUmQU7NHlqPr53CwTeYkuv2EVDgYXaFpSB7i3Rz702LL9rlcXIV0y
	i2iKlDzJ5omYPSxB/30nHogUBqhRUq1ruXIVa5CKsq32E1QOt2mfy0AAm1enfRBB
	K93/At46yKf1zSpgXKlHQOXNDMd3uhGMT4wOAy0ggLU68sQt2GgtDdj978LpxLrM
	QPOO0fpul3Xxr+qJjxcSo2G8od3PUEqYtsbCPvO8LGsLIwTSiVkdue4l0clg9maI
	69M4Yw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fctc8hvh8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 14:05:47 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-388b404eaa4so4354139a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783951546; x=1784556346; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vonu41nazZKgZgFzgiMlMdUi1Svr1anpCHuYLg93am0=;
        b=FezDkst6R0rzQ4shxNcDzgsikXGchrhyv5hK9iF5aH/ZgTrvT1Rjg5MQgIITjGSxKH
         wlALvNm+l0hnpY7LohD90Xx8SnHE3afJ2dZv1a/My/pHWpMsBq57fnOp2KWfA8n+c5Yg
         ESNUUi4GwIa02uEcJjORCC2eYbVCPWR7zUysS7eopfgd9Sz2UTJM5PbEtF7MuQTVcDH9
         tmsbP/tg55aDnZmRPJsrgrpigooVgT5ZI0pBvt/CM/oDr6++JDU0uHYWN2DtzWFhpRzL
         ZpcKifWUeKp9gAqzbvj1Qiw8/bhhJQUo2g60UU+CbZMZvsk/NCAazZu1cCSjVUCEaejw
         Nu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951546; x=1784556346;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vonu41nazZKgZgFzgiMlMdUi1Svr1anpCHuYLg93am0=;
        b=r1LneeXNUd2irT6SNa/sI59HbdDynLpJOSBasPtuLKKuoQvNY1Wg5cuQnZUKikpKqd
         Jy3ZM3borWELJY112GI/vSpuKPHL9Ger0GyzKokD39OCXoY+hKVS/QNf6IetwEbgllTq
         EuKoD1SNojYB3cnzx+mwPjmeQp2qTfeUAyeTWAifKErsJsXC7LLVkZaQJRDlenMs/FN+
         1thgHe3X3PzXnHJ8PocioEdcS+HVCO7kJoDEK1CFO8t1oBMxxjE5YAXTYQpTStRMvu2D
         8OMNtuZjdy2NIzI1z67di8xCDFzrm5DT725XhReME3s2Z/UR9q+9SR3LjaCDtGcF5zIh
         8uEg==
X-Gm-Message-State: AOJu0YyrtphT82r5bn4OiITqMxz0bOIx+7sZrf3/OHGZNvl2OVmP4oLc
	7Z602amD1wtJO/4CXEGxmmwLQuR5EXAbFQUDkzVtRD0P8TfuJkFdfbsDRArVnF1suUpFSxli04F
	H3OkJazyJJt6J224U4G/NN4e4pMt3QFhsgnWcAcYCi65DvsYFCiG9G9Svj5ruAAaQPeqCWw==
X-Gm-Gg: AfdE7clByXkQY1k1VYmDYIpRfXltR1Uls0t+mjcNve36k5xayNupiZAlaBVPrinV2PD
	wqn4Q5DTJt6qqq/pOX3Cf9FdF+ia5WJGi+hSj+DTWzQ5RHNDHFUWNuSoCIAxxeiC/vRQ83hva9Y
	cZYqfVr1y9rHtI5Lv93JmW8ygYI+g5RpAI7dVgA89JIAmjbaf1/UM7Lovj6mAo6raRkPDY1flTc
	jdf/lL069/sS/2XD8BqePKyjvgkeqh5o31bqtBFcVyG72X3l3HydvOpTbIYZbyRPwsELoPy212L
	wDKvaWfiwHo9R1oJ95XTIZRFOTbvpoXSsezOMX9kLx7W3i8CI1dELdeMIt5rLrwNfkSU07BdxPI
	xLL9y4Ry5ckfbC9P/h+iWRHjaLhApV0zsqRzQM9tueTZUsRk382lVV2h61nwRCwRivw==
X-Received: by 2002:a17:90b:4fd2:b0:38d:a76:6470 with SMTP id 98e67ed59e1d1-38dc77c61d6mr7972434a91.39.1783951546515;
        Mon, 13 Jul 2026 07:05:46 -0700 (PDT)
X-Received: by 2002:a17:90b:4fd2:b0:38d:a76:6470 with SMTP id 98e67ed59e1d1-38dc77c61d6mr7972363a91.39.1783951546030;
        Mon, 13 Jul 2026 07:05:46 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm77071424eec.0.2026.07.13.07.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 07:05:44 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260615112103.601982-1-jtornosm@redhat.com>
References: <20260615112103.601982-1-jtornosm@redhat.com>
Subject: Re: [PATCH v2] ath12k: fix NULL pointer dereference in rhash table
 destroy
Message-Id: <178395154431.877545.2513390294359874255.b4-ty@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 07:05:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: bc-WuUbeiIYYr1uOkrCD72ST4Tefvt0g
X-Proofpoint-ORIG-GUID: bc-WuUbeiIYYr1uOkrCD72ST4Tefvt0g
X-Authority-Analysis: v=2.4 cv=UtRT8ewB c=1 sm=1 tr=0 ts=6a54f0bb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=C_xO_HesPfbxFcvR4REA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE0NiBTYWx0ZWRfXzR/yw3puMByK
 djZQxFrrkSfW8U8x70AX09cy6cIREUEzVM179tPLcM3MZVq+z6yJMqmOrN0ghStpf/KH050WLql
 dugtT4nh60E5/+0AJBj543Y6Ga09M2M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE0NiBTYWx0ZWRfXxoVZmldLkhpj
 JCsyu7p9epPFPBVmsN6h9uX5PrOp4FBHNK8/+SHJDXOW0OarJPf1GXVtPaYIucM5i8q60E9oVqG
 OBm5iQFVUZ2ZypXchWNNHy3U1ESL0S4gz6r2NuU7Ya2QcirSnCiYhwknnDsJDkcrSPG1rhBh3kM
 XT1yCo86GoLPuiS6WSGEhh+qNw+HuilMb4RA+7zLOJk+BBGeusQMS6XnB8lzd2fz99s7MZjwyuu
 K8wnliGbgqIPKV4DSlEY3L5DdzPPPLawcri9rnza6AjBOf0O7qBobPeuvpzfRFOkrYMfRuduokA
 FtRNAcp6pSXXttB+Bbtm4eFGA2ADglNggNdi8aS9/RKQ+y6rgjMC1SuiEbLjPAMpcAab2R83t+z
 CmIXjJJwN6cvciqF9r5ISfx4n2K67Ex1n2BOCW+bv5u5I1/M4shR+o7t7RtkZ63BTcmVniXeU4W
 CDtuqU4QtpqGDR7B+RQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130146
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38974-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:jtornosm@redhat.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6AD0674C787


On Mon, 15 Jun 2026 13:21:03 +0200, Jose Ignacio Tornos Martinez wrote:
> When unbinding the ath12k driver, kernel NULL pointer dereferences
> occur in irq_work_sync() called from rhashtable_destroy().
> 
> Two hash tables are affected:
> 1. ath12k_link_sta hash table in ath12k_base
> 2. ath12k_dp_link_peer hash table in ath12k_dp
> 
> [...]

Applied, thanks!

[1/1] ath12k: fix NULL pointer dereference in rhash table destroy
      commit: 70231dcd782201579990ded73e0435d18bb524ca

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>



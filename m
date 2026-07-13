Return-Path: <linux-wireless+bounces-38975-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VhugIkvzVGpshwAAu9opvQ
	(envelope-from <linux-wireless+bounces-38975-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 16:16:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF08774C415
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 16:16:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="Dw/Tpsuz";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="M0JPDx/3";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38975-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38975-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9438C30F6B01
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 14:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B4543802E;
	Mon, 13 Jul 2026 14:05:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8840438010
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 14:05:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951552; cv=none; b=DoU/TXH4QMXne8Vm3SLwY2aQ9LaS+0a0ttg6FcQvoUfVlyXBBkFMXRRZmAm5eGepsy8Jt5FZYcXXYPNFdcnPpOxwe5N9a6T2xKes18hFqINpcjKADgPbz/q3H5w1xLOoIu6rcnDPUGXw+mJ4NV4w3F0AW39DGlalJJYvY8A72aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951552; c=relaxed/simple;
	bh=I5/9hti1F32/1KPjgPHJLHPIR9GYaZbSmdeYSSl/ye8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EjlL77dimyfDLOsPv6/sfnHhegYE1WuoL/7p8Pfv6lJHaEad4JnaPtZokHXV8JU9EXaTaAP/+f3M45FEa0EDGq2qU8k2WVPKIwCPGfcDcRnL9fCLZ0ENKbt0CaXQvKk03ppYMIjbtKlB2f0hNEUBD7PxqFFdvDNhr6LLRDBBDos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dw/Tpsuz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M0JPDx/3; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCE3x71561428
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 14:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2zAQAxgJzZ/6GwEnCRM/0TDcISXjQZ73thDvTZAC/yY=; b=Dw/TpsuzJVR+Ua1G
	QrnHy5UsASTpfAkdoPbOHC1779GGPY3avXE8dKLCZYQI6e7sfcVcbYKWkMGMSoV4
	VYx87FeH3lbAanef+i6uFh0W6sdgDdefzQUmmmUGeXxSNvsrgLoCcgsPZwbs+LDV
	GIE9Q+E9ojrE9VYtBLt5532t5SvB3ChPHtdfdQnZ/4W6fXQQW8i9xTf5gEPryOKN
	6hZpsbQeb3qcnAtwxEm3cCks9OEJSyy+vl4dj8iIevRF9yzu2l1aWjt7e0pZ/Xa+
	Mz0FTXqXU7E3zYQ+bacVoeoPxzWBOM3DcZxwpNNvcHN9iztfUFczLzZSA0HcrNGI
	PpyBLw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjn3av09-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 14:05:50 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38db4fa2e25so4035032a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783951549; x=1784556349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2zAQAxgJzZ/6GwEnCRM/0TDcISXjQZ73thDvTZAC/yY=;
        b=M0JPDx/3LT1mc1vM7cECxFok8/Q90GXsdEDWjtq9kOQ1zAyHnzwRWxhV1jq49hpg3F
         hPokrIOlm5nfJ8vaLQUF8PfzKVLuowbP4kO8V3yOcFsmWEfjbiDGMG5FKBSLTa8F03NW
         gYTCs9KK2dnYTj3e/LJ4WTKScKvt9gbbS0C/Md3l3QBbYDMFnAI/AgS2SuuYCgydtOw7
         ciukxuc4apBck512b0+tXeu/Iwznv97iZz0yCuBuvuq9dUoR0U+i+ZdqbUB0LhF1ExdJ
         XZ1Nxc+Epu2uCwQPbCEHTA/gfTbK1stzg3sTs7c8IwqmiE84tjgkUor1QPtBHYhNavFu
         Z6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951549; x=1784556349;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2zAQAxgJzZ/6GwEnCRM/0TDcISXjQZ73thDvTZAC/yY=;
        b=Q8d2y09rEOFeR8C5qZc+sbkau2JdOlTuMt5z60RfFx9TC4Z0tjwOm1V73oIww1PTEl
         lhYhew+f1HFVXOmrsGV+fydPLMcQCVVnKpE6Bbn6sPsvZU8Gb2N/eJ5jSDS5eYmEjpXz
         tpGNjAl+g/yUAq5wt8GhT59FanLGYYt9F/ue66dz6Wae/g/ib74wFD9hB/LC5dWE9ZoJ
         EVJJu0GYkpESmWrkm1Er4wEwGniJ9DIA4CEh5ZxgN24u95OqY15k6ydRIwt2ndu69qna
         D6tsVwWbsNMmrm1dCPMYZBnDtzjJ6WoP+kW+pSz4AIck5Ldzw1GVVsY2l30ilbG/1gPR
         mW9g==
X-Gm-Message-State: AOJu0Yx3JGSzk01Dd7coS5uK1HZLiMvyKG3v62MhEYpaLBC9ZpNSs4S2
	rm0wUimZthY/aY0OhVrF8vJoFpAmxpnMh3VvqJ//Mw50lL8nW/1S9c6jhtGXkpVGdOazMn2nR3+
	reOphw5UMX+eEtoHn5g7hdLQMgZUq4vX6hGv5TpwKGw4mxArmtUHQjkaCPGei8qVGIX6Bh2qk4y
	D+Bg==
X-Gm-Gg: AfdE7cnpGMzMVsj5wpUqDjeB98rppD2SKQIdkDDP3VIA9skmLfWnRAOM4q33BHKs4Rn
	XWrvxiHQ+64JfmHDYgrdoD8S3asHSr6Zv34Jg4ITUO/6rKYC5tKPHhCnBodelEI7TrZ2OAfPdEP
	jBCpbTz2TtPy3CGkeSechkxJJhwZY2f0WBlp3vLLrNpbH2EoPE5nIAPu0wttOlWHvaDSDjvp11H
	fl48fdwjQTvDjgdTDLNt/pTjNh+dI6SYBhoUHeweVY8tJxJKUfqgqzhSmNqh1NuWaQnW8M0/7RP
	K0VE2iIWksWHbfuM6XxJ3CPJRZW5hFKF5PHZvA1UZjVSqDh5Oskxx1O09kpAC90FFcTTUzkPQAz
	13FbaGagBajVUQLsKH7eRGLJtHipaFzMwSCZciLrwfCLdTZykDN/92zaoryEExbbtOg==
X-Received: by 2002:a17:90b:554c:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-38dc73c3441mr9757725a91.4.1783951548554;
        Mon, 13 Jul 2026 07:05:48 -0700 (PDT)
X-Received: by 2002:a17:90b:554c:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-38dc73c3441mr9757684a91.4.1783951548071;
        Mon, 13 Jul 2026 07:05:48 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm77071424eec.0.2026.07.13.07.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 07:05:46 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tristan Madani <tristmd@gmail.com>
Cc: vasanthakumar.thiagarajan@oss.qualcomm.com, johannes@sipsolutions.net,
        tristan@talencesecurity.com, stable@vger.kernel.org
In-Reply-To: <20260702005020.708717-1-tristmd@gmail.com>
References: <20260702005020.708717-1-tristmd@gmail.com>
Subject: Re: [PATCH v5] wifi: ath6kl: fix OOB access from firmware ADDBA
 window size
Message-Id: <178395154621.877545.8436478026493365127.b4-ty@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 07:05:46 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE0NiBTYWx0ZWRfX3qvhkwsJs30B
 gieYNQvR1NsiW6NDy/Rwym1f/jo6H7gTso3xCeyYkYZegNIA7+nKUzwbdh9+V/z//yVt0lYyEma
 JrRA6WU12R0d5R+D22iQyMkl8kaVdyz3yPMqwspJGPqI1mSRjkr4TGzgQvpvN4sG1X0QfM/jBR4
 qLqvd0yK8jXaxx8DCS20aoHw5EppYFQ6RPfD0d3S5qwPBJpoPO0vytnP3TgTzrVD+iwD2iRughH
 FCkWmLPEH4SXkEe9ZhJ+3TRQ/GCGXHbZXfDu1Aj6TfFjCWmTRkEFDE6yYwsWtGEPbb+21P5A/91
 yqk9LfvsC1VJvOOtbIoSGZncfiVkd/PD3T813OUY0/tZNy70BgoWuOc/hpPsyoQbeci4adzObAL
 v3SZVJXWP7nLw49RJxIBdKl8sK5VJ/8Utxw+/ydjoS/csYA9KSGbVZtop/0FClhm4t4jmsCrpiS
 w+FSEAH6elDNd0Fke5Q==
X-Proofpoint-ORIG-GUID: R4E2x7hETPRn4SygDsTw6PqWYsADVisI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE0NiBTYWx0ZWRfX9CeyofpFWuN+
 HGy7rZtLFuF4Bvttom77iE3Xfhj68kuZqXy5Kkioao+in2nJ+UxiKuSE+hlVqiyJWdUOm2S09kA
 QA1544ANo4xxL3qUwsM5ONwj4YhSqks=
X-Proofpoint-GUID: R4E2x7hETPRn4SygDsTw6PqWYsADVisI
X-Authority-Analysis: v=2.4 cv=aaJRWxot c=1 sm=1 tr=0 ts=6a54f0be cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=9zLzvLqbpVBzozAWk5sA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130146
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38975-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tristmd@gmail.com,m:vasanthakumar.thiagarajan@oss.qualcomm.com,m:johannes@sipsolutions.net,m:tristan@talencesecurity.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF08774C415


On Thu, 02 Jul 2026 00:50:20 +0000, Tristan Madani wrote:
> aggr_recv_addba_req_evt() logs a debug message when the firmware-supplied
> win_sz is outside [AGGR_WIN_SZ_MIN, AGGR_WIN_SZ_MAX] but does not
> return. The out-of-range win_sz is then used in TID_WINDOW_SZ() to
> compute a kzalloc size and stored in rxtid->hold_q_sz, leading to
> zero-size or overflowed allocations and subsequent out-of-bounds access.
> 
> Clean up any previously active aggregation session for the TID first,
> then return early when win_sz is out of the valid range, instead of
> proceeding with a broken allocation size.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath6kl: fix OOB access from firmware ADDBA window size
      commit: 44126b6994eeb28f2103b638e698f40a1244f327

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>



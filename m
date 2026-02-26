Return-Path: <linux-wireless+bounces-32232-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L0lFTO8oGnrmAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32232-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 22:33:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9EC1AFDB2
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 22:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 219FC317DACB
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 21:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE73B44CF5F;
	Thu, 26 Feb 2026 21:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pKZT+2Ut";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SI0VhnfJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7592877FC
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772141357; cv=none; b=GDVT3Q3+GfMCsJ6vY11qFt9g5wRLAMrL60GevC+7Y4+MHILWjhYMfg3F18O63pn1aA7esv73vEiHaUJa7BkW5DV0xvrRJdjX7tWChtmJWqWodaydglsMRFPNJc6Ko/Cb5PJjU52XexN67ERhJnCaRR7HXT04tdLvbGedo9kJkbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772141357; c=relaxed/simple;
	bh=m0oqlmanXQpb9KkpjTvR3ZfiyhIlAtXDQfYKuImuY2o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Vw0Yp48dI3X7wh0cdzIj7VIjtny5GmTUjVKneqJZzcsBVYuJGW5E0iqffIed8odRi2HbowW6K3TBWtydpff91V844ZPG8oItp9dO/1Sc0i/IJ5lWM17WMZV7VNijPdjFmmlxi6VW3uTMqPNsB6eHWCvVF0j2biO2XDtSk8zFrDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pKZT+2Ut; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SI0VhnfJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QI4Vu51394935
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 21:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i41LecPOfJlxUTAd1CxctSLP1z3s9+uc5PK8POH9+cM=; b=pKZT+2Ut+p/NqQFx
	qE57mKPM47T5exFxy7KmC6sC4bS15UZuil3vhBIDVXi9DC8YtqFWEwVfii5bbh+v
	ThQOejz0YSWHWVC7Ts8WNj1imPyNsIyFJ3/Le+hjtR4g0FThTLN8WefkiSFh5bKK
	/1pYFENzgb3t4SEf3YDG9Xki7HKXFPk6OlWme4FXNpgPLxl393PZ3qhDOpGH/ZqV
	aOFFnMMYrciKWsSn0HEFiJYPfSKrS6HcMi6ABSIiJsSbKD5d/jZqRlh+QabqduHl
	apC8bJSA2JZmaiOq303TGYUsIKq7VMNzVQ4xuNN7vT7uGfEBFq7HqhH+NpEG4mZP
	xlMWtQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cju4r0ueu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 21:29:15 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d4c27c728eso17975810a34.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 13:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772141355; x=1772746155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i41LecPOfJlxUTAd1CxctSLP1z3s9+uc5PK8POH9+cM=;
        b=SI0VhnfJtP7X7/LWko7P+NFKx65GSgMLiQ8XyNklDClZMgSCEALOe5JDvkHqH3IQNO
         lYQbwante/jm4TQc973GgfaJ8qK4ym3UKRY7i9rq66+YWB+4YWXZPApTm0FWFElux8MX
         WpeslPGRrY10MQWhbfmBAzvOr/ukha3R5A05g2Cw28WGkqojvu1Ogm+NG4u721hKc+ps
         dZsW/KJGKSf8C8tcgqG9+XNkcDxNqesvbxCki0kkExosURRIRwG66jAnkUtrMz9Wiy3O
         W+00D9D1ftqCRynEGcfvmevIuRW+3YkLfZVbTZmkvKkVlZDMG3ovUgvJPuRXq6l6hqGc
         0Y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772141355; x=1772746155;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i41LecPOfJlxUTAd1CxctSLP1z3s9+uc5PK8POH9+cM=;
        b=DAn+VQ3NMnU8ua18tC4IUz9rGrBvtN4ELS+l47851vgRAzKmKpZpWSezgR6OznWlLe
         piTN6Abq+cAoJEddr5blWD/z/6JvJc+SmpZHEjsW/3JXZS99NIloHRhCTF/acRjIZncJ
         GxD3/YlYuK5o+fkDh3p9DS/pB6de8+Qk791IGN7XlXn0rLMNSoIJesGoTdWOQDB1k1HG
         aM0ax0LK3joXy8eMEv2vZzIyetKdpKFCpyNvubUK9YAl3tm5HinmCV9DVjX1KgE8jeAi
         vM9AeSOaVuK1jzAl53q/tccNyD3urMuuuU9CZfQd5aih/xVRkNEeMmCLleDV61sbPI4a
         h8bA==
X-Gm-Message-State: AOJu0YwfV5tS07zHcyKXG0BJLnOvfoPU1M1JUdKp/JgsFqsQV5CLBj8p
	QEixQk+uAA0VuvzQBDnuxIJJHBXS0TcAjksreOIHoG94TR0DpUbfufovdLp8EgGQ1cit8LfjEsQ
	GXxJKNbUCa56vX1YGnRDNv4NYmtxyyuQjGRKJGM9Ac4D5qXHiXf6NQN3NBMVWjFyKJxWphw==
X-Gm-Gg: ATEYQzyBefivt2JJYI+KSRBN6qeL3ENFpMPAhDYiJ1heRHm72R77c7J/JmBcXAiYu11
	cTr0Q2s9QyBh/S4bdPZlhsxh8hKg3K0deLF+dbq/T78sE8gEfnemYumSHywn4O2JzGlA1UxXSBT
	7x4djohA9lxwYOhPEVCNRA9J6rKC3ohtKnCwPq8DJVIjj1u/Etj9VH1DC+Jg6uQVaB4XuDnml1H
	6NETVDJSD1YFRn6g/ozTNnDsdoCUzEyrB6n60Aaq+LekOp9ERHeY10Km4amRQs2TFwnzWfWkEZ3
	lvoVy9q/Ovd8ML2x/OoIqQJfYqGPzTyaKv120Mh+8eIoTfEDLsssvM15L3KP5oXFeKaagzDBUq3
	D2y2jMKKw9hgjRo0D+pVKkX4rkgRMHYjCMQtvwlyUrYE33zbp3LSyKoybmQeRxgGLP8pm+v892F
	tF
X-Received: by 2002:a05:6830:2b0e:b0:7d4:c471:c221 with SMTP id 46e09a7af769-7d585760234mr2465041a34.10.1772141355230;
        Thu, 26 Feb 2026 13:29:15 -0800 (PST)
X-Received: by 2002:a05:6830:2b0e:b0:7d4:c471:c221 with SMTP id 46e09a7af769-7d585760234mr2465033a34.10.1772141354906;
        Thu, 26 Feb 2026 13:29:14 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58666ed17sm2866703a34.27.2026.02.26.13.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:29:14 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Aishwarya R <aishwarya.r@oss.qualcomm.com>
In-Reply-To: <20260223132622.43464-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20260223132622.43464-1-maharaja.kennadyrajan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v4] wifi: ath12k: add basic hwmon temperature
 reporting
Message-Id: <177214135345.1298720.2239590933156720521.b4-ty@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 13:29:13 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE5NiBTYWx0ZWRfX1CbYghfkffex
 Q0cinYvvVt9NJ8gvoaU8o0X42TleMN9V73SwUh7yuvQrIz7uwDPazwqwqeyL4a2wLdTr3U87H+0
 gP7zSYglegRexe/V3Z45iyMrvZO8WgbGtELwV/GWIqGDx6rjAWMLeb1XsbjIO73IE75XAiwBss6
 C3+Cd2wK+fic2QvdPDHuxyVvHJzphKUo8zHLCFJDhw47/+ownBrLzoiu+eTT4K0qBdX5oc0T+Mg
 1u5y5exmI1KNTaeGXSKi4c5lZY+BozLs4gyTuQm6qHC10sZCzTuj1IZlDIwjLinydFJg8vHzCbc
 QD/HuIdhPVasIlDVAEGitIiGjrDA9M6VVN+kbWVYbPGsILz8YCgimRjuZywtklg+9FORruerhVi
 NvefxgIFixsm/KP7OKIXtqncSMfSrV5iWdfqL9w3a1GgVppegtL2ArHYGdrho1v41LV5qg+jDHE
 0ynelzGdTPmpDpPuuEg==
X-Proofpoint-GUID: M3w4os5__iJG_xPQeq0eTB8nUQtIrgul
X-Authority-Analysis: v=2.4 cv=KZzfcAYD c=1 sm=1 tr=0 ts=69a0bb2b cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=b3XROT7bV-so0M2aTt4A:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-ORIG-GUID: M3w4os5__iJG_xPQeq0eTB8nUQtIrgul
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_03,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602260196
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32232-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EA9EC1AFDB2
X-Rspamd-Action: no action


On Mon, 23 Feb 2026 18:56:22 +0530, Maharaja Kennadyrajan wrote:
> Add initial thermal support by wiring up a per-radio (pdev) hwmon temperature
> sensor backed by the existing WMI pdev temperature command and event.
> When userspace reads the sysfs file temp1_input, the driver sends
> WMI_PDEV_GET_TEMPERATURE_CMDID (tag WMI_TAG_PDEV_GET_TEMPERATURE_CMD) and waits
> for the corresponding WMI_PDEV_TEMPERATURE_EVENTID
> (tag WMI_TAG_PDEV_TEMPERATURE_EVENT) to get the temperature and pdev_id.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: add basic hwmon temperature reporting
      commit: 151322bccdbdb132f5a73cc8ad5d3ab89b90ed52

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>



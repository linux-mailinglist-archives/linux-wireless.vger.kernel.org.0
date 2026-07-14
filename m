Return-Path: <linux-wireless+bounces-39112-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yg6PMhd8VmpZ7AAAu9opvQ
	(envelope-from <linux-wireless+bounces-39112-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:12:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32417757C35
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:12:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=CjrOYX2l;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=kMTC9p7g;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39112-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39112-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FC6131F9596
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 18:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8163F9F41;
	Tue, 14 Jul 2026 18:08:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D6027707
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:08:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052497; cv=none; b=AEYL7fCb5zMg1vvVBCQ0WmMSDclLIphV8Iqu5HZMVfmPyTiQXa8GsYd041ToE7fFQLzQv/qr7Wr6WuYz3MW/4ixbNWvwgodQBYuNXxel6pAW1flvHUVDxokWLvN0bE55xGvqBUWCgiei8NiXEd0KGB47zCDWfMVEsymQFWBvUrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052497; c=relaxed/simple;
	bh=+a35kR41+F7uUQrVMdPiNLpOZ08dvyh5CpyzE1Bdrfs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gNgpBaFyJ8c9kIccC4qpj0n+wt4FbiEpHVz8B750WRvxX+/jhpE+0+iIf5JTYplx2tJw4ro8LPUGP8EbaIffe9HBr2pnLxFgVMr2SfkvSsjwNbbrwjpo00dgRY3oFRSVZ7GLQSLWz9TDgzvsIN3xzZkvvO4gODgXETFOYvp0FpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CjrOYX2l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kMTC9p7g; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EG6lbD1096990
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	br81x1q1nzbk+cirFCSsM9LN/LFwG77ajgiIvb9OlQE=; b=CjrOYX2lN/t7fMMj
	7JbTx6O0wiEh6OhNXmm+JcIiFiz11UB4dGdswPnY+XcrrvLA7tVYqrnisc6xZcpD
	paj+s3oZLbYdUTUeS9xQP3RPs7ZLK0DuU9XhIZYy878k9PPo3ovSM+75qjOhJ1XN
	dBu7x/YRsvGMmCT874XOFc2hN25HiPT1AJDYKt9h3CMDURVwpk3EtgTFxCSvgF7h
	/UAbVaPPSDalChjb5KzJqGlFugbq7qy2XYVlC5ajStsN1Sz9Zr09LVnGI158J2d6
	q0U2NQ6ojWpcj4Ccc/YdWsTmEvWCiTRWpukVJW905yRIPfyNLhEH/WVmG1nSN9jj
	Tdq5Cg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnqs9mj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:08:12 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92ac0a54110so725435285a.2
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784052492; x=1784657292; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=br81x1q1nzbk+cirFCSsM9LN/LFwG77ajgiIvb9OlQE=;
        b=kMTC9p7gZ36caTBVXV/ylMCJYz4TvZ+/LA7+mx/PR9MnRQJtZUuKREGZXuoqRVUJVX
         dPQEZKGgvnY1rKVXtXVaQK+6G9GtMxx1z9caBvas5nS4kPgagDguFDhR3degLf1nSTb+
         SDyv8FuKkXamzvGWt9ooH5HKI2KmB5dMTDPPGHN9eY3cXQn9eJX3UFgO4KqnQoehI9vl
         hpe4iKWcfzMKk8HsL+Atrpzwh3tZaoIrFb4Lj2+Tp4CaNCUMYHjKYMLscTpwvJO4uLXd
         zf8KsLJiKxBcPNAfCchXu6VsbXt2xOTg1J3J53Gw9OleiKhCFZTYnMiUP6xcvdLFh4er
         fQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784052492; x=1784657292;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=br81x1q1nzbk+cirFCSsM9LN/LFwG77ajgiIvb9OlQE=;
        b=IbJKNSasejZrLblYYXucqHImhtgR9MSIcoowzaPSC30KOCXgrPOYSclAtha07/4a1l
         Zu0FvdGU+mpIVNPtY9kaNa7H0gv25F9wuQlSvXH/V628cFmizoX+3+jHw4oqbxs7+MuH
         PHm6GuLfqCi+u1p7ZmaoQBj+qiTN/tl/02VgA0ETdi1W/D3yHoY1J7PR5lDiLhSw+NHa
         syE6fbBPLXgWW5KP7MtoQMD3IbSogy5H8WButkZ+9Tzaf2SdLbKqp8cYhhbrg2laFjXp
         2OpI7KX377dFrA+4zE6+pjRQJdE/kShxfY9TNTFLRAdV+H7v8XeGV8wJZ0rK9PCg4Dsg
         HMFw==
X-Gm-Message-State: AOJu0YxDjKAmBuTXl3HvUncKrmrYA06J+XMCp6148VFj9uOAyMmKm0rN
	+GQnY+2o6OS7YkO9xjOxkSu37HPn5mdOD9O5WTCvGIPafS3lGCS6+Owy5nQY/OKFU88Dc8oWcEG
	adirFlkl1zUckM7oX8VQt2OLts7zBMXdW3PHHDWbtWvcHYUUtOwLqYyR9fK5MTLVY5rSktoAHxG
	0tvg==
X-Gm-Gg: AfdE7cmi5AVZOl4Wkk+0QGZVjnaYlN/TUACAUrnmehiIgkjFLzQYZ9+9ZC1RG0Iaxgp
	vX+pZ0gJmvsrhDyME+bXXKz6ObmMHCWiGM0tGrDdqvCKRfV0meU/QlVStx6yp/evCfTjnDUnEpR
	G48UBoz679hRApGIiPZYHNPAxCi+EDWOtlJduC3nDmh+aOee90Jas3MEe4xF907XrngA8AbPuxf
	6oxEmUROdREbztrdjvFSf9qYhnTjYZGo01vojdgsqWrFIzlyPr0skWE3eYIwKareMkbo4JZ0u+6
	w1xE2msPrSOiVFXlUDET9HsqURTPfaK0TvCW9nDdUOTUQwxmIT5chpTtOogKyOEousBzfduKMlK
	TkQ9AtDvS5lBKiwI6aRBKTQV0gqAj7t5/p20N/tNbVn5gEimbUaScELBb1RPja0uA8A==
X-Received: by 2002:a05:620a:4011:b0:92e:c116:bf0c with SMTP id af79cd13be357-92ef2cb3f99mr1415266085a.85.1784052492264;
        Tue, 14 Jul 2026 11:08:12 -0700 (PDT)
X-Received: by 2002:a05:620a:4011:b0:92e:c116:bf0c with SMTP id af79cd13be357-92ef2cb3f99mr1415263385a.85.1784052491854;
        Tue, 14 Jul 2026 11:08:11 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930759c63fbsm465448885a.22.2026.07.14.11.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:08:11 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20260711-ath6kl_wmi_scan_complete_rx-v2-1-22dc0f7f45e7@oss.qualcomm.com>
References: <20260711-ath6kl_wmi_scan_complete_rx-v2-1-22dc0f7f45e7@oss.qualcomm.com>
Subject: Re: [PATCH ath-current v2] wifi: ath6kl: avoid buffer overreads in
 WMI event handlers
Message-Id: <178405249055.4102418.12665944241467036889.b4-ty@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:08:10 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE4OCBTYWx0ZWRfX9+skDCOscRRK
 W66y1u1MSwyiez/HSW5v4e3UVxnbfRL2NhZjDbqx/oW+iZSl2+CTowZvnbzpCbClYdoNIVeMEnQ
 6loM54fbj+myQmno45mW/aJeae6A7XjxATKhErwiQI158H/BxKwRFR0nhNYE0EDcCXwcIzNBR8l
 RsEN8Z4wouD3206Sp4+XhN2lqCyGL6RD8aJEIO4mqiGcL08qCSZcB354nnOi5cyu4r5Fb3Kn6eG
 gaQVaqBSC8nf2Akv7D5Zbsh79a81Hl5FQfdAngD96JMks5WY72/j1BKzgi0EDrxGC04ati52CJA
 Jt2Hw3Uwcu+z70agCnpR3ipeu5/tlnEv92P8e1SGpWvRWQJn7+M/V0CyiOVbZUnyDl5XvSiQM2J
 wBK5ZCWQp6714lrJnZnjI8B0Ob/0iauzCk83J8pBmeVWTG3/FQB5HuERVPrg/3F06Gs5zYWQcpB
 L2sKwhmhbpT6yr7Q5FQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE4OCBTYWx0ZWRfX8jTYXNHx7TPU
 PQzBtiQAThs5p7HKuptCUnvzy6KdrVhwrNehCKCuBjkDxKYyMMYh94r/tZxq5ThBNf9o7bla+uU
 waPlPaTMct0otE712hxGJIQ1UrpdzRY=
X-Authority-Analysis: v=2.4 cv=U+Oiy+ru c=1 sm=1 tr=0 ts=6a567b0c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=s9TpVWqw8jPjvRZ-RaAA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 0qhRNWBISNt4InMGsbwZLRa2OOjk13eh
X-Proofpoint-ORIG-GUID: 0qhRNWBISNt4InMGsbwZLRa2OOjk13eh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140188
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-39112-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:jeff.johnson@oss.qualcomm.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32417757C35


On Sat, 11 Jul 2026 11:04:43 -0700, Jeff Johnson wrote:
> The following WMI event handlers currently read from the event buffer
> without first verifying that the message was large enough to hold the
> expected event:
> ath6kl_wmi_scan_complete_rx()
> ath6kl_wmi_addba_req_event_rx()
> ath6kl_wmi_delba_req_event_rx()
> 
> [...]

Applied, thanks!

[1/1] wifi: ath6kl: avoid buffer overreads in WMI event handlers
      commit: f78703024c71ac60033139b42d040981efe083bb

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>



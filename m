Return-Path: <linux-wireless+bounces-32209-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHQFGldsoGk3jgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32209-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 16:52:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C04E31A9245
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 16:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6DE130D9519
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 15:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DB031329B;
	Thu, 26 Feb 2026 15:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WjXG+5eM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NyED1BjF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FAA22F177
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772119642; cv=none; b=WBNKLEzSuS6qa1f+usKkp9l47mRwIFGxt0BYfpIYbyOGdylK25NYLA1TKAEncxsYEvt//wI4agT+JeNXOV71/zPoBjAIZARxX27e2r3HGF7Kjojz+JroVFd9+wgdooenr762UXWHU+0VbL1nDPeIv3wCY4qcAWfNEz8fBUT96cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772119642; c=relaxed/simple;
	bh=Z6PgnXLPKQQPbj2BBujCEkgBzogYr3ggKlIotBixebI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QkfCnwKqbhbFF20/hsyi/dy8uJIng2gUl5r4uqaaGgM31M1MQ4c4CCdxqboI8HiXWGyim8p1YFN7pZpmVxqBUId4hL0elh/XeQjdgCcQKtEAjNOfno5Ix4zFD0QIIR9rW+OCsjJIN94w2ElsYNg63S4+c1enj0HYndXbPas4/p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WjXG+5eM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NyED1BjF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QAKq0s339793
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 15:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uI7jqudlT/nod2vOvqUoKazQSL4u6lDKrUzQlW7Lpvc=; b=WjXG+5eMERH83hJi
	qo/667Jjzxc5nZpLAaGWfiUgNnQXIIyRJ4UXB6t/Hzj9PSJpV8MvXYX0vgOC1UN+
	KJQT7R59iSfu6j/qCFWIEFnssV3iT95qQ5SqUWuUPwYfojfVEtMmMPMlJzHFI1Yj
	m9euBdKvFV45+0jIHCTncnU/Uln9lEyTQT+PlUroXRcsbXVWDQ1eUIdMlKrzrGLS
	MUp1X2PZnBslGCv4JhdDMbHbY82vvP7bka7UYR7xMOGLepPJ9Tl0JcTyhnxUc312
	BNORQKrRxcKHdYnJN69gGxpxDxCUERASiSAFBdbnUlxsRTKqyGSkVXqqwPGhq5Hu
	TPNL7Q==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjae0trfp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 15:27:20 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d4c7afa9e0so14811151a34.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 07:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772119639; x=1772724439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uI7jqudlT/nod2vOvqUoKazQSL4u6lDKrUzQlW7Lpvc=;
        b=NyED1BjFVGkeEW7Pb0UtU8OeIokC0cggvn3cqC/BqeTta5cDXQWqFUMsdMtHY4Hiz2
         eHeVKsXe1eGfKHmjQ0P4Wtu5piN++u5yLgL32iC1JtPLE+DvsNIN9DuM2lPuo95MrTwA
         A8lxY+7bYnnh6fx1RUoOHGvg6Hmv5h1vhaAYk2bVb7DBoRzqDElzzfQFC4LmFi1jLur5
         ++T5zNFwpekS/PsWZde2noKXbiGNaxUg4+QwcZho2Si+SBYtiqCq65zLcCAdciGSxXrO
         Iygz7Ia40dvdjk7jBq16YL5puXc3/yRS1bYcn+QBpBJb9SCUnzxZgbzobuDdg4nEaFqb
         s86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772119639; x=1772724439;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uI7jqudlT/nod2vOvqUoKazQSL4u6lDKrUzQlW7Lpvc=;
        b=uEHdUesry+Rt+/jzJKNEnYKqeXGeII865aRNa/JXctY1hFBoXXbWALLPPiFcXJizkl
         HJDpVWY2hTRY9j1D1zFILznS+ql20nMUfhC9/mwmMG10zSqnDAYMAEtRdl6OMHdbUyIF
         sFw3H37UmK5TCfHZyQrq61mGj9RDTRvF7agsjqvbNcv5SS0sa7oIvwTzT15ApwUAiLB3
         NYqNvR6eAaMAhKXTaPRfbpUy7dPqvVnlGV/Hl0tHoBoOghzAdEw+q8nAKPbShnIzO0xE
         7add0jFuSRjHeoQ6StG7Nx371aCrPdz/i7q32T6YAUbLXcVdp3rAdVaSkAbMsnCKB0bR
         +liQ==
X-Gm-Message-State: AOJu0YwkekYFJ9qczcXeTKmHsksdeo9zoMwUhKciwww9DlvYrb5/gSXS
	O6ckWHVKekj4SmixAg8C7mdNsJHHZhWUsj+lnhgc5pSPfa5n0NqyMUC4CYZIaV06J5n8KRpK5NY
	jfyNvYN3P69oxCLWvZNegzB2ErTWQkZTZUml4asaztU9MAHwf9AkCQ84M1wbRK/xTNAjRaDyiGH
	xEjQ==
X-Gm-Gg: ATEYQzyMtq+GutJk7/va+cxo/g72+a8wQV2kWi2t2sP8kfBIALY3Cj8CWHi9EPa6dGh
	ajoGNqINDh4EwzZN/ma/evff+wNgDdnM2FNkkybbXOpayJjVM5OnJp6nA4H6F36V5xuF920TaJC
	WmT+SEo9+LcUYPgDPW4p1IU2E617xZIuhZUQkWmIy43cuh9WwiyxZj7oSH2/rj4+VFAzw2t2Wwv
	GValPqpMNcpIgaa3G+ZZfY4itz2fZ+HgKMAD7JZstjkj+9U15yKsSnwqBCxERV86RGsqdANK4XI
	6UoVgWBzw/KsiIHGNcKm8Ar6wAvX8nE0ADSBtJtULv+VhIVj+8IJv9dj/BtGE0VEvvKc/AoVpb2
	Ay4+lPtBAfyVKZiN9yMansg4Bv0hrPcqH3CHFYCVaJSJ2VLX2nqHTzbD3sD02o94JcHqpQZdpta
	O+
X-Received: by 2002:a9d:7f85:0:b0:7c7:6558:277a with SMTP id 46e09a7af769-7d52be7aa1dmr9465093a34.15.1772119639195;
        Thu, 26 Feb 2026 07:27:19 -0800 (PST)
X-Received: by 2002:a9d:7f85:0:b0:7c7:6558:277a with SMTP id 46e09a7af769-7d52be7aa1dmr9465090a34.15.1772119638904;
        Thu, 26 Feb 2026 07:27:18 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58666ed17sm2085996a34.27.2026.02.26.07.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 07:27:18 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
In-Reply-To: <20260129-ath12k-fw-stats-fixes-v1-0-55d66064f4d5@oss.qualcomm.com>
References: <20260129-ath12k-fw-stats-fixes-v1-0-55d66064f4d5@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: fixes to station statistics
 request
Message-Id: <177211963805.49925.10997614192406169999.b4-ty@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 07:27:18 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDEzOSBTYWx0ZWRfX9raWXEZ1RCiw
 27SKKsXnxvgOIgj23RWOlZCcJAuzsq0ydJ8FQFfObAQB/bGXk3nbyFnQjg0wQMC4Fe/6QaQsIdd
 40X0pTKhgSy2Z88WLOTD7nxP+Yi8vdarHV5F+Ab9bCsVgvyFi/sW/8OvaeJoNW/T8Nm2WdnjFWw
 0jgoMfldB1Wmd5dU5wja5iRJAruyKKaKl+Rk3Sv4AH680sMo+aaAz0xAEooeKSGiDBgGwpDyXfJ
 xz256YE/XLUEFaatXeYArIy8hY5SitwnCzy+b4ItWKPsiy/6nGr7AdVI25xyKDc01S4na7mBFYf
 hmHIBiI7ixH06bhd15tIeJzfH3l59yoy/BQxJukrsiUb4HoGb7MhCsOcc4CyngAX5nwTCGGINp0
 Qvhjfx1kjX6I8SRh9q6eZdUfpQ9j4XoJ3dh0o3PDZGloBWs3gzubLS0u31KQXhYLJFrRZE48tWf
 dwWeegBJtHaFlBghB8Q==
X-Authority-Analysis: v=2.4 cv=O7Q0fR9W c=1 sm=1 tr=0 ts=69a06658 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=09yQsDFYmmylyj1ORGoA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-ORIG-GUID: z-q8BbbLhWX4yC9babcAbohWrCXrsas2
X-Proofpoint-GUID: z-q8BbbLhWX4yC9babcAbohWrCXrsas2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260139
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32209-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
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
X-Rspamd-Queue-Id: C04E31A9245
X-Rspamd-Action: no action


On Thu, 29 Jan 2026 10:24:04 +0800, Baochen Qiang wrote:
> ath12k hits timeout and memory leak when requesting firmware statistics,
> fix them.
> 
> 

Applied, thanks!

[1/2] wifi: ath12k: use correct pdev id when requesting firmware stats
      commit: 8f153eb745463b0715f1aad41e765cd83e9da8c0
[2/2] wifi: ath12k: fix station lookup failure when disconnecting from AP
      commit: 7259b1a0e54c2d3051ac8f1eb01de121b11118ea

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>



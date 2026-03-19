Return-Path: <linux-wireless+bounces-33485-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJV8AaQJvGkArgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33485-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 15:35:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B012CCEC1
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 15:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A9283086DE1
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 14:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397C135B656;
	Thu, 19 Mar 2026 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QarXSthN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GQY1xAGI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35D7373BEF
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930415; cv=none; b=f9fQFZeHcRLTWS8+J1eRibJiUni5OgtXZfGMwMElIsWspYPGuanwPZ8FWJ2TsriFyGlcd7nipIqYMbx3aaT6V0LXKz7S2IfgahY0OlW7I/eYllAdMAwZiW2qBaJMqKdjU8zuXBM575NbGKvuaXDgkz8+NiSKazSNhkFB7aFipB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930415; c=relaxed/simple;
	bh=gv/hMc9jdlSB/rscIFbQEP/TqOb9j2QNFxeTSfCKR1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=icarSbp3VjVxezRyh09y4q/aOuBKs1QiszVtjl4DPC6Mo/gtsgu/o/Eoqflg8+ltl2uUfoS3lgYiDx6DCsDk6GWmpoWEevmPXSiqlLhe9/WfvXYuHsvtnDdnZLordRgb2fu+B3RLb5ongeF0lGfg1oKG0gDYQRFxo1VvfJOXfoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QarXSthN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GQY1xAGI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JDFMa82910634
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 14:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0WO3yovuzRdjBUY2nE2AcEq49hPJ3M31tQHHQvF6ywA=; b=QarXSthNOTFkFQkO
	al/Azz2zcOzljz5BjrIOubnbmfGGbJxmmQ6cd3iZzccgYCrqJkS037p8ei3Yw2FW
	fMzY7wYL+M5x2a7CvA7ibvc7ftLepU8jZ7dSDLW/7wr4j35FiC+FuakovAkA5bEm
	oGhBZx90FsY6NawlnD2SuBkSEDvQ96PcWAnwDx73MXSASpvIq5ZWduCJ2vU8umlO
	caIcH0KHhMuAYkUt63XzSI7fCMxfvrzce+sUtWLDPgdWVXG6MaJGGEkZZ+JBYqeT
	9j36iOmD17f1976Lp7w4hBhFRavlaBWubY2hiT8tzn47U08eYCOK0hBVP60sOrdU
	sPGUNw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyy75urwx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 14:26:52 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d7e0787438so2150897a34.2
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 07:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773930411; x=1774535211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0WO3yovuzRdjBUY2nE2AcEq49hPJ3M31tQHHQvF6ywA=;
        b=GQY1xAGIZYBfMZ8HFqzjBWfRHLQbkLwgn6iJZtpnYTi2+wZvOUzUcGPPiCqlB3/dxf
         U/O/+h/PrHD9s8GAz38hwaetwHdBLy/f2bbHPGcjkgqyNUxz2BN6N1vGWT6sxq0uvpUT
         JYYhtiqnPk8Hgaaow8VEz4c4FvzW99+QFqWrBVEXmsorZ+NBy72CSu5p2kvJVBB4ayy9
         z2+sMrXs+Q/KqSskYyS7xUvK+7UpLdTilzFXEsmeF9wCFTKWls6/eye8yvaVppjsyUGD
         0zEvycxEe3bB8xdHyVM1LJPR/homONc/F4QHunP5SFmufkLRbrzD3xaf5ug/2F/GwAav
         zf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773930411; x=1774535211;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0WO3yovuzRdjBUY2nE2AcEq49hPJ3M31tQHHQvF6ywA=;
        b=I+686R0q7Fd554nalYFX79CRs7lERD+uOozIMvpm1K77ek0t9s0yXNBvXJcvkDXMuW
         ETZZr/WJt3SR14xX2J1KQGyARlwBXFwkjMdOgXLfPsB3Ksq77bif1opKPYKiEZeJeKkZ
         lQh+aAxl8IIjuT670v2MVSiMEJktnSwapv1H+pnPEuMOYPBP0EHixxAFmk+np5rWLg6L
         da8xNc2rq9i++ER18zHJnzvWKFojSGUl1G5Gia9Bl4B8nDMIXVQyGycfOkGqMpC7g3XC
         ZtxpGiB0jzvxKLyYLj9zmCELR4Gul7mOn9KebLI5rFcQHaBPSsFj1DtOFnMXx5NXquw2
         3ocw==
X-Forwarded-Encrypted: i=1; AJvYcCXunaKIMLDy3lWDLRewNVXxYNn9Q6rCCffj0DXbAVuFW3PZqNek2jH0SVND0AOM1Z7hV3AFtobw5UuUs6dl1g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt0mRKN3UVainVdIl9zgW6QWtS8vL9m3duj4/H4V9WHXNBvLVs
	WcvOrxXHM2R9IJpfRDzTKB1ztyNlr9I75EBIqijLLFKPeZjB9Um9eY5YLcg5DYNsJTE1aLIJHWe
	HHteXsMDDF3sII14EcwtdStS/L1RO5k4YZlTiAXlmhEhwW5bLP1iab9//XTOqwzyf74n+hg==
X-Gm-Gg: ATEYQzxjK7clPAttNBPcSbtkd2lC2+j4vefVCJhq6ewFpqTg4h7FuVolOwfsaHWb8QR
	0xFCZbO7NOYbmhz9N7UAsshAXnKARFwhX2nP0++8MXeNP+BGySM9iyI8I0+YqQeMfLbgY1ZOLYe
	nsMHdmRQssyfbwQZHhj5Y8MdFDwoDgbW/T2S0T9PoOpGQCt25Zxp43ndF9VzEF/+8vygfiuhfGH
	Yo2KIc6nbJoFpR+phtSPWgeFCqL0ySBALaDezKxSrtkrijw2ZhpWeag8xOKF16u39jNr/quSrEL
	cwUmyXYGAWRGWizwK41sZ8jVUdNCOYXlTq/x+idF39RiJHUUCWmcAWTjfWzHNNhNrd5E8IpBtuC
	jqIvrw6c1GKrwov72DNgj473f1ulVVhOxvGymY69XadkV8c2bcZgqRuLkGZf61DE6FVIO3Twe77
	ssT/zaV0mnjH+aXQ==
X-Received: by 2002:a05:6820:61f:b0:67c:1e60:3e90 with SMTP id 006d021491bc7-67c1e604939mr746055eaf.6.1773930411228;
        Thu, 19 Mar 2026 07:26:51 -0700 (PDT)
X-Received: by 2002:a05:6820:61f:b0:67c:1e60:3e90 with SMTP id 006d021491bc7-67c1e604939mr746016eaf.6.1773930410817;
        Thu, 19 Mar 2026 07:26:50 -0700 (PDT)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41bd2d14b63sm5729630fac.16.2026.03.19.07.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 07:26:50 -0700 (PDT)
Message-ID: <51e28a7f-8362-4bf1-9b9a-9af9cda1d748@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 07:26:46 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] wifi: ath: Use the unified QMI service ID instead
 of defining it locally
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, konradybcio@kernel.org,
        andersson@kernel.org
Cc: linux-kernel@vger.kernel.org, Alex Elder <elder@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-sound@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260316171419.2619620-1-daniel.lezcano@oss.qualcomm.com>
 <20260316171419.2619620-3-daniel.lezcano@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260316171419.2619620-3-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDExNCBTYWx0ZWRfXxzputor8om5u
 HcGz6vl5wD+YTzs6IGYaZ7IZUzd3k4c1c+5IglzJD8wrVcosy3ov5qwZ8B8N9dE5axzcUuwhZfN
 LVCEHXCZs/H1Qb667icGRWE84SiLEPacCBmgCc1x/UsscS06x1WtpGhtPgC//XXusMNzyyEBvit
 aaAbmh/W8tljT0n2dXWaihRepqOpUIFNpZsEg3+HVvqZ1jrmByy17asVBDxeBpfKnUOzk+Y3O4q
 4pWtYLzSpqHVL4iXsf4r5sMlEhVXiniqzvcyJxtIbJYuTmq1C+ifLR3DziovLFTo5YlbcTCZL01
 TPXzeyTLcQ3CrWqqpp8VKvqzy2E6jqyDotN8J8EuIjPtOJrBPY9JUMpHWNmTRmEw3/DbDkhz5iT
 B4/hPS65Q2yCIQ8plsqNEYrnoG9p8BJ5nC1Gj53TJqZuXFosNR78v6kf/KwylTWaDdYwNhs/8gN
 tDYQaDTj9sF1wgjBijQ==
X-Proofpoint-ORIG-GUID: _Ugl_N87inCEa5smpxCkqiCrqS0_9kVP
X-Authority-Analysis: v=2.4 cv=A7hh/qWG c=1 sm=1 tr=0 ts=69bc07ac cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=yAZrW0GqhKXZdV71gCQA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: _Ugl_N87inCEa5smpxCkqiCrqS0_9kVP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190114
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33485-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 71B012CCEC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/2026 10:14 AM, Daniel Lezcano wrote:
> Instead of defining a local macro with a custom name for the QMI
> service identifier, use the one provided in qmi.h and remove the
> locally defined macro.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

Bjorn,
Feel free to take this through your tree since I don't think it will conflict
with anything in mine and it will take time for the definition to propagate
back to my tree via the normal workflow (which I would prefer over merging the
immutable branch).

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>




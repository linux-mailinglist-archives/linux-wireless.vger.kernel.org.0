Return-Path: <linux-wireless+bounces-35584-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG2JBzjR8Wm3kgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35584-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 11:36:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC514920EE
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 11:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 267C1300D308
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 09:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEDA396D23;
	Wed, 29 Apr 2026 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W9VWA6S3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V4Wf0eoQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DF33890E2
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455053; cv=none; b=rPN0rmODlyUFHd9l6RYH+GbnoVdEFLiPZAg0KVkEvpHXGuATQ4SERQcL/BnVHCjLaxhYjdEHDRNBN7XPjxhdVpAYc9la9i8tykvXE24fGaXNUffXLWiAAoCe7QlChg9OgIWz5EddqLpsfdkqmu2FsIZcc3qAd/RmXMqjsgm45Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455053; c=relaxed/simple;
	bh=wC9jrPQBmpCZbW2mnXn6p/4PAelbyjfeh2Yka1RlPpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNYUBR5ClchULSp3sdLNCYOn5KsJOHMn5uQ1enj0on5Npw9zwu8PhoqjZMjM0O3ujIXgc0kw5OWGWRxBHZ1J+DDOyZIR6nfx2w6YcZ7Hw6M/22IHuh09uIbGMZ+jWpmYEGWyXIJAKbby9y3obfY0czYnnQnqozIpB3W+z2UAOYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W9VWA6S3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V4Wf0eoQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8qE743066928
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 09:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gTbNCeRSUqu4zDmkAqRY6ARTuww7wMu5rx1tnXDAf20=; b=W9VWA6S3iqRyvA7f
	IQsLcQMaUAo6MrX9KGt2ltCHppKvhII5yVDzVpDzHK2kuP0AaZslI8qh0v3tmdex
	IHtPapbJQePeiqdCjlTAhAHyEtwfT+4h6Zf8mY9rL59hDCZTT0mB7QUXD6jK/LEX
	YPlvGlHt/g2oCFgtmk6x9RRZqHkzt+idAJZfRqmiEEqUOF9drtciI0/PpY5w+sH2
	wGojjqWxaAsCUJXiE3JP1jCqQkACKt3T6EDFIM1KBOrrB9G53FbimPaNVhoSbKrh
	h3vOEeWBL3aHeQUyDP5coXfAtAd1BplIgxkVknbEbhHroHuyOjpgWPgJcKcqpcyx
	cjXoQg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du7sx9tv0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 09:30:49 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-573ac60fcc2so141030e0c.0
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 02:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777455048; x=1778059848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gTbNCeRSUqu4zDmkAqRY6ARTuww7wMu5rx1tnXDAf20=;
        b=V4Wf0eoQAMEva3tDdlrX9/Zl9AZ1bYSngQg/oYmbri4DFawPnSwKNq3piwSd9kYUpE
         wJMOp9YezrpOeC69LdgSX/znAt2WaolwaiJKh1MceLb025yYmwEvSmSta/Jcq35nK+WP
         wBjGkelpYxRvdJkqEWpA+vLyGKMxCRc06xoyTg6Erw8FT1e+87RjsjHtDXshS6VNG2Kt
         Vfw6sTmLtrIWtP/Jrl+IbgfcTIJU+GcNoDXYWEx8Bj3C7x33mRyb6OzLQHgUhwZUN3ui
         dNa9CIjrWBJ9N0vDukQG8M/ieGF6fxPlbBSG3TD1Wc1A6l9DWi40S3VcUuWjfYoECdMb
         W28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777455048; x=1778059848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTbNCeRSUqu4zDmkAqRY6ARTuww7wMu5rx1tnXDAf20=;
        b=cASS6TgrEUmmMam5b1+obBaHzZaZJePvwVnHRQXi0v7k9tJ6U2EeFfTVqHfoY2vlBC
         ip33FD4PaF1N4OI5rR7BWM4tVNaMwfM2pdyLKxEidgXd6nCskEMuqL3WX6qLeIxDFSIL
         Y31pNl0CS4JROb9pJt9x7Z52m8Bud72aHkIdT1b3+Hyc4Ku1epmwF8hoWZ0rGg5CmOpL
         y1DZ8FrpnTTCh2ymad18rXAITWCvfTiRfk6vYmV8/nvXBouOgKEgFxlUPNT4ZdTNExae
         b795cp/CkwvcwHoREzhYMKAayk4ZWQOxGc5jDk3nMeUphzrPIWIUl6iCM73SOElyUEC/
         Klrg==
X-Forwarded-Encrypted: i=1; AFNElJ8UpmhHWtEHlpZcBMESRMRmQ+il0aKn7YTGj9qaOb3og6t4gp2sy3Ek0fdlrE/Rhov4tfAGhtI/SzDW3uCdQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy29aWds0k9aZGPha3tCgWmb170ID8R1rSe17d5MrUheg2t3psv
	GBxH8St2hhiBQVeI1UUZLe2/biPsb8zGKC/zMfHYliQ+oe+LZFx/uTElx8pfo+l7kw4YGYWxLpD
	sv7E6RN2WfWEh2qVIMwAUGo+mTQFp2gUdRt3GA4Y94av0XBe8SssBqpnircclkLwP6hztVg==
X-Gm-Gg: AeBDievdlGqzWUnjPaoMZIVs64hRC2m6qLmrLgNr0VZsGvrqrd/X06KletmhRt5dCKQ
	FpmmQvfiMzKcgqt5pbkum8B57BkNFFQ/Tfb2/69FkB18ml4vkU0C/gXBZKRpyuKNi+rhP1kLdxJ
	P6zHr4czWANGHaUrurLtZ/X0sXNsUf1WlagJ/LxKATB4aRqvWNPW/nueLd4pB1lqMrJ+rSMtG5o
	Tz6OXIuiEXIKcrmOjLgQWgbMA8/ElYL/MZfddCtTOhaYsQn2gK+wxeztWWWfFkK2njKMBbxp7lP
	EMo/bNMCX/wSwyqNbITrTh2oexprUiegRgjLENEceRyXgmkVUbRFy+cCAJWrVeMAVOzaL+ItDLC
	776LAnozZIQ2WqIBdbApqeJPxmAGAbDYz+ie6SNr9VBEPopPSg/tJyHrLxjRDfm4h4M8LPVNXm5
	osw23knxc8uxPtIw==
X-Received: by 2002:ac5:c894:0:b0:56f:6edd:77ae with SMTP id 71dfb90a1353d-573a293d531mr1234264e0c.0.1777455048470;
        Wed, 29 Apr 2026 02:30:48 -0700 (PDT)
X-Received: by 2002:ac5:c894:0:b0:56f:6edd:77ae with SMTP id 71dfb90a1353d-573a293d531mr1234254e0c.0.1777455048034;
        Wed, 29 Apr 2026 02:30:48 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb985e1b108sm65753866b.50.2026.04.29.02.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 02:30:47 -0700 (PDT)
Message-ID: <aadfa862-a99e-4214-b19f-6854672dc8d4@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 11:30:43 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] arm64: dts: qcom: arduino-imola: Get WiFi MAC from
 NVMEM
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
 <20260428-block-as-nvmem-v1-5-6ad23e75190a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260428-block-as-nvmem-v1-5-6ad23e75190a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nKB3Of8NcMg_EVDyugakFmjG4fpzURG_
X-Authority-Analysis: v=2.4 cv=eeANubEH c=1 sm=1 tr=0 ts=69f1cfc9 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=vtxEUVkT7waMBiOsAPUA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA5NSBTYWx0ZWRfX7ue2JifZSbC+
 E2mZdV9IZJ8TF90bQ0QM8IlZi8TdE1aMRZjdS+dfDLqAfDzKUop6Fr44wlKsGFkcg37Gds2WVwI
 6gUYpXfBGfV2MvoXgDGmGIvy0T5c0NRV0MSKBOK1OUMYw8emOY/qZP4fkb0n/AOCgKczy2KYNrq
 mTJHe0bx9E99PbTWQ7vfd9bz8CWd1j3+ygJ0DIoUe/qIIEou76IGTMiySYVhNJI1U4Se3r1pbGN
 YL03KU/GfWNoy5SCrffUzCBgUN/iVo1ypWN6K3MQOqEKWcaTARVTs4aow0lY0jeaCjthXG0jLM4
 tdXK5N6IoTRrxFecFgyYdadqLCEiXqywOwdKTfri6qnnL3/3z4gejaFyrif8IhhoPbSoH9vF8pY
 o2cKGq1JSD3H5/6EPpvxAJvI19DeD8MezkGYiK6Hrq7Q3EAyiyz6rRHFn6wWrUHKZOIBZuPXCvq
 abEqekUFC6u0XLX+wkw==
X-Proofpoint-ORIG-GUID: nKB3Of8NcMg_EVDyugakFmjG4fpzURG_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290095
X-Rspamd-Queue-Id: BAC514920EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35584-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 4/28/26 4:23 PM, Loic Poulain wrote:
> On Arduino Uno-Q, the WiFi MAC address is stored in the eMMC
> boot1 partition. Point to the appropriate NVMEM cell to
> retrieve it.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


Return-Path: <linux-wireless+bounces-33912-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLeHDE2UxGnH0gQAu9opvQ
	(envelope-from <linux-wireless+bounces-33912-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 03:05:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 383F432E2F5
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 03:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E6F330131AF
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 01:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E0430E82B;
	Thu, 26 Mar 2026 01:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WwBkdG+b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FsGH+u50"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2DF19CD0A
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 01:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774490355; cv=pass; b=aOO3N755MWsOxbCUmaXiE4nw9wS98hVIo4YdS6nKyYzf0aVTqV0zwhR0aV19E0WEE1ts7HWUf8otIKEda08CjAXHnMe4rdzDebuB+PomkmiNGziwFjXT1Iil10PS4ans+jr5tv3UuMAUxWu/xuQM4Z75Ee8NbAx/9e97TxpLdAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774490355; c=relaxed/simple;
	bh=DFDO7VGoKhW9LibtcXJDRr/OcOi2kDPvbAzGM7JHtTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKbJKIP761Z5fZH89EDyZXXvte6UFtonjjjkDNgfIg2yqc6bPNLoUXM4tZgSPkf+4DbxxU/2WsaWJIyu7QpDO4djFxbHfgrmCqWUeS1WssAYBNHV2Mha8JtO6UIDkl+rIkfjUtFxMDM7MxgmN94sXjwOfF6WvCcIwhZNoeEotrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WwBkdG+b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FsGH+u50; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q0op521432757
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 01:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jPgKrOCs8BV3rkHFf7zJrMHg
	/ajlW1vtOsuJgIMhY9c=; b=WwBkdG+bMNAv1+H4wYjSz+Puf4Hojd60sfYMbVLz
	6u7s1GcBAeZuf7rFY16XZRNNen6tUahqZmtZfxf58grsNZS90izuJb9GyiJNwA6l
	jyUtMU9c9gJrXpHrck5QXhLaP9mrc528Jd9uoA8GdtA9jR7E81ExXKHhYrVut73E
	4cXbuRf7ecmlOPp97UnydVYHUSGS0OAIeX3tJ/pfwMRH6KAgVVPs7d2FLHk+1Ddp
	FBl4Fp4U4exKCbvqP+V60vrbx6Lk00MyWfKihdu/ceUYWdPEjIB+Btbd/DQ866/+
	+Xeyo29QlF7hT/ik0vreVZ1XWS/2CHif9EzUZjwWwX9YSA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4jc51xf6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 01:59:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b056b2f0cfso6946495ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 18:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774490352; cv=none;
        d=google.com; s=arc-20240605;
        b=jApY+CbT4o7neAZGaYtvjMEwGEblNbqUIzMw8G+UU9cGkfe83POaPxZ5RXXZSZrUID
         grLLqLOiU9YaANfsXih0xf73vFCOiBo+juFP1KRHCM3S6FxJ00gUvNHn0w4G1OH/lB/y
         VuP/cJ/NnedbWYoIrzU7iMAP4jEiQRoJeMB1tvEjT+51YOWgKhAwS4NDumxbStWj/GWr
         1v4bzcwgbi/scCFkr9mo7dpg+G2XIEA2+3+i9q+EnJqOowlss+zBcA6nvJkscHhQ4DYc
         dS6TPHATGsJ+0HMQIFigbfbIKWaSm0Kylvci9IezitOa+Presi9njBGYqkg0oRkdu//f
         tkNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jPgKrOCs8BV3rkHFf7zJrMHg/ajlW1vtOsuJgIMhY9c=;
        fh=ZTAC/c0CTVRdM1WQX9pbyPAEMbOATIs/K/R8ROj1qCY=;
        b=F9gVrzTrAIICGwMcv8WxIL7rTNV34INfo2KPkGAEYGE7klM1ulscFWyjt5FNndHYgV
         NkvhtcBD2RlU/1IA30Ak4HuG1zrMt9IH9721sHi2/I0hk75zQ/SbclPeyBUtuT8ccbWL
         KtwzBPucIihZQHQA8DR3VAYi2X0sPPWCnAjXIjl2F2KMJTuNveaUe0xD2Z8aIZnDh4+C
         LMgji9JRcHz0lTyg7XqpW3H15H2DxbpziUDnt4jWt74Oot3VVwvNAgdpLIULVEwWzAXA
         pD4IFEb/QPm9gZU+u4thi8OUGaaGVzaoGIt3RNimPiDus+sNVhtv/bWmrnEIPjlj0vZG
         F14w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774490352; x=1775095152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jPgKrOCs8BV3rkHFf7zJrMHg/ajlW1vtOsuJgIMhY9c=;
        b=FsGH+u50H7hDfd5eY6SMzZf2ZvWyoVTnMNCWjJPTLS3kggeS/gFVcJBGGv7yziQsyS
         /i6d8hUCNePgWlYN7hb7tHmM7qW204DP/QnUdjnLIqnk/uyeTcrkOZspBM9SE7n77Fc8
         teBXf0BBTs+xTbv6mZBB527yG3Dw00KW4O1XrMifTRStePSGj2lATMjVECwswLN+l5XT
         apKNXqYLhwjZdLf+4yLkWcy/2Pwt7749+JZrnLITEEPo8EPEtCKl5HzZOfiHBhaN+4ha
         sPusz3Rg2PTtRTOPzoxQnmhxvnlfrz4sYKGx7cSz07nWGF7SMyV4kTb9Go2j48HizDj6
         OKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774490352; x=1775095152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPgKrOCs8BV3rkHFf7zJrMHg/ajlW1vtOsuJgIMhY9c=;
        b=oaynEfN1zRsWr2DuJASBJNvrK6m86fnDIlxPc7u/HVNEN1KL3VZMvO4kVtbJ0R5/s+
         ILZ8WD7bFE64Xp5rhNQ/BLDbh/1W3MUIiY2n5Wm08S4u7VrbZQ2WAznn0e7aAbD0VhW5
         rF+LkszKyqrlWHvXIDT2msnIOQ/4Smx65t05fAPRWWn5NBvFoC/KoJjVMaxqR0ta5DWL
         CppG0f21gESkVJTbGOIFW/26+3oR23oeIppp9lO+gKrtuOHUy3wC68ESd7H4GijEzXU6
         6OHhMpCG37WHAllXXJ1j3xnokdQ9y+Hw6kLeTGP2VBIenpWtZtr0ZOyjJCqS8V6wxA4V
         4oLg==
X-Forwarded-Encrypted: i=1; AJvYcCVBYIqPMxiW/JshcusaxW60T39WWqVHkV4f3eOhIQHRe9AP+v7MBHOENoCGqhfRe2vOzDrkcfqzFI/WuEFdeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3g8FY2hJKph/W6OsG//eK0BB4jWswmCa63PU1DLSBu/drbjCX
	3Ef0I8KDRRWAlLbkVEjptC2ZDyqBaEoX49afHjiZUsrVZKTZeAFWVvoo79/fOUkAWOmi498fDSV
	7nNbA2dU/Y15LbTrNUc5yEMyIwFWwXsr+LMakW827M4gjwg3Iuxzo/SYQGcaM9XEsul6xlIGi8v
	APE+zFWdPKSQ7eoF+ANpn7R0feARsXsW37B/y78IvoUiba
X-Gm-Gg: ATEYQzxB2+II0EITlR2CZPGDupzYGGJyOpSnT0futazqDKhRyhBfPXFe61QZdUeLmYK
	W5f7A1+DbZwh5HLGIglwhLjmFHot98YGgctFREOUhIfEl0Dg9LE47fWs7XToGuMG+2Y54Sr8BnV
	CFCtTbIro+AYqnt2G6htDMARJyxWP6FFR1p5PwL6QWV2q49uOMxDMC6OsOwVw7ZSgy6345TOnJw
	GUPAtYgd3EF5nu7vw/s
X-Received: by 2002:a17:903:3c47:b0:2b0:6df2:8cd8 with SMTP id d9443c01a7336-2b0b0abe504mr63387195ad.40.1774490351607;
        Wed, 25 Mar 2026 18:59:11 -0700 (PDT)
X-Received: by 2002:a17:903:3c47:b0:2b0:6df2:8cd8 with SMTP id
 d9443c01a7336-2b0b0abe504mr63386895ad.40.1774490351133; Wed, 25 Mar 2026
 18:59:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
 <20260119-wcn3990-pwrctl-v3-7-948df19f5ec2@oss.qualcomm.com> <a75f80bc-d2fa-41f6-91aa-8252fbb415e6@ixit.cz>
In-Reply-To: <a75f80bc-d2fa-41f6-91aa-8252fbb415e6@ixit.cz>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 03:59:00 +0200
X-Gm-Features: AaiRm515yskxcvd1wtiR9718njLTgP_TuNpDNdd4YtWA6E6jp6B_uzG9KDE4-bM
Message-ID: <CAO9ioeVLy_Uzn7L9MyET5wg8CMR132+Dda5JzjdAB=6vz2NEMg@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] arm64: dts: qcom: sdm845-db845c: describe WiFi/BT properly
To: David Heidelberg <david@ixit.cz>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-wireless@vger.kernel.org,
        Jeff Johnson <jjohnson@kernel.org>, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: WU7_4bcjSDzlqw3NLkzyMuEObuMmJgDW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDAxMyBTYWx0ZWRfX22P5lG93LjS5
 CwZw2G8nONmZRJCVkZTOqedCHc5sYHRuD3VrDrox4HHmHcDaSkOryB7D5Wt8h8uK8zloAPXuFqw
 pt0ixrTev74IoG132AywZSb5LSKm+k+0pq8F/M0+yxAA03zzDtNmVoC+vxZoTP4s3VuMNPae+8v
 GbJ3LTkkrBcONpvCpXh7JOKw1wc6d/fUFln2oKHeyMm2kX6nwSthpyUzo9f5TOq6iJiv7rmENW9
 HMnRnvoYvTn4CPg/2GDeKRu9IpoZU5u8I+xLmEl11WYKVEMorijO0Xd9j0R1sl201vw+CtgqPbl
 VlV3TtY54uIktTWsYE0s3wwu2oWnVkdYvdN67CVZcBo6Ai/bBwwtF1CJmpzZbngt9S9h4TqRxvS
 tCp9kpxZDtGW9RyeganI7RydpymjzoaUmV15V7nZ9RmpSCxbUoUBBnSOkecU94/i24s58GbatD0
 60XCXpb8Q0HxBVG8Utw==
X-Proofpoint-ORIG-GUID: WU7_4bcjSDzlqw3NLkzyMuEObuMmJgDW
X-Authority-Analysis: v=2.4 cv=KaLfcAYD c=1 sm=1 tr=0 ts=69c492f0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=l3dzM3eKOFk7Ec1IfqUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260013
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33912-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,quicinc.com,chromium.org,lists.infradead.org,oss.qualcomm.com,holtmann.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim,ixit.cz:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 383F432E2F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 at 02:02, David Heidelberg <david@ixit.cz> wrote:
>
> On 19/01/2026 18:08, Dmitry Baryshkov wrote:
>
> [...]
>
> > +     wcn3990-pmu {
> > +             compatible = "qcom,wcn3990-pmu";
> > +
> > +             pinctrl-0 = <&sw_ctrl_default>;
> > +             pinctrl-names = "default";
> > +
> > +             vddio-supply = <&vreg_s4a_1p8>;
> > +             vddxo-supply = <&vreg_l7a_1p8>;
> > +             vddrf-supply = <&vreg_l17a_1p3>;
> > +             vddch0-supply = <&vreg_l25a_3p3>;
> > +             vddch1-supply = <&vreg_l23a_3p3>;
> > +
> > +             swctrl-gpios = <&pm8998_gpios 3 GPIO_ACTIVE_HIGH>;
>
> Do you know if the GPIO is common for whole sdm845, or it's only recommended as
> reference design, or nothing?
>
> I did test defaulting to GPIO 3 on Pixel 3 and WiFi works as before, but since
> previous downstream kernel didn't touched GPIO 3 at all, I'm worried about
> toggling unrelated GPIO.

It is an input-only GPIO, but nevertheless, if you are not sure, just skip it.

-- 
With best wishes
Dmitry


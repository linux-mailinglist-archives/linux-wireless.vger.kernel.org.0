Return-Path: <linux-wireless+bounces-38442-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /3ggEObkRGrj2goAu9opvQ
	(envelope-from <linux-wireless+bounces-38442-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 11:59:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A23356EBCED
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 11:59:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="MaL/yjKM";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38442-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38442-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B18C30309D0
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 09:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB853FD96E;
	Wed,  1 Jul 2026 09:58:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AE13FA5E9
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 09:58:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899921; cv=none; b=jpi5UTqovo+FhbArQFCUxbDFe1r159sDH9aw6u67+c1b4rwYVW4R0otnd4EreEU5avie1rdsUZFCE+i9ULBIzVzNyXCP99YeUMHQ8i00Kh2WGnCeGqW4X22xEIi8EXwMnoYRHjT9XpZW5qY0H8QQRnaWnlTKKaV9rDBqJj0xIgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899921; c=relaxed/simple;
	bh=ydO8Ft5Urm5M09KG8cScRhJ3iye6Vu29eRTcwv+lefo=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cyzxA57NHz0mCdvdwskqnNspxvG+LFkTHcKpiOnovcphSF2N5neJnuTESMtqm0Kdk5Vz5O74jIYrPloVHXg5QdEaUNuizLh+2+ODr8TuIc9AjZKtob3kfxzxOd/S/oqfY/wNsPw8pno8D2PxsUtKxO/+Y2xpgiJNjVY71Ocvf84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaL/yjKM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124131F01564
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 09:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782899919;
	bh=ydO8Ft5Urm5M09KG8cScRhJ3iye6Vu29eRTcwv+lefo=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=MaL/yjKM23uRludhdmmZ/pKii3StVcH78bbsWWybDYwbISt2i7e25j9KBm/ltPtyN
	 XGTqeiB7Ui1fTWOKe6cmbDOaCa0Gh2ukI1Blgh4/JscEquN0V7NidxbWcCsMFv+Jd5
	 zQ0wlXT1RcXbBR8YbeJ4zQJVuoPwzoSktWAr5ZLETC3SShkGudys8nIebgKuotKHkP
	 IX/H5FlnXGYAgS4ozo7QnUmxjTPjq8d3Ak552DqwKFVad8dtMolWhL9gdsliRc1QHb
	 BhmUGZrXTuZoVIIBCLI8L+AAXP/DLxfCSDDCslKePeVul25emIdooLYApll/O+VzH1
	 yilRymzKctFNQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aebf9a50b8so329794e87.2
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 02:58:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqFhQQ9JwbzjgYYoV6B8D1TFKUrD0SjByf8Gnt3/rqWipWI8RmS+3d9iASTbcwW17k3c7llKkHuyXWmJW/anQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAlEvq1Q1e9GFGDqgSB9R12FjLmofsWrKYbsLcB7cgwvmj0frt
	npNze3/9BQnsF/g5mtOdO/lp2n1EXZ2ulC+WmIVP2FMgReCU+b/+1/nxuv4245TbNEw2/N+6bjP
	UxyDWA44G3zIMmUuMvCpMihbypr5IUnCsDN6mO/o/ng==
X-Received: by 2002:a05:6512:a34d:b0:5ae:b952:6c with SMTP id
 2adb3069b0e04-5aec6797747mr213198e87.13.1782899917728; Wed, 01 Jul 2026
 02:58:37 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Jul 2026 05:58:36 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Jul 2026 05:58:36 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260629-ipq5018-bluetooth-v2-3-02770f03b6bb@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-ipq5018-bluetooth-v2-0-02770f03b6bb@outlook.com> <20260629-ipq5018-bluetooth-v2-3-02770f03b6bb@outlook.com>
Date: Wed, 1 Jul 2026 05:58:36 -0400
X-Gmail-Original-Message-ID: <CAMRc=MfTh4-RM7R-Ku=MFjo2EQLoe9dt5-AFBtrMx+zZJRHKLQ@mail.gmail.com>
X-Gm-Features: AVVi8CcMVsM_VtMs4RD3avK1gS-7SxkMAq-P9mHbEgm5Sdw31SbqOo7iHTS4Zj8
Message-ID: <CAMRc=MfTh4-RM7R-Ku=MFjo2EQLoe9dt5-AFBtrMx+zZJRHKLQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] firmware: qcom: scm: Add support for setting
 Bluetooth power modes
To: george.moussalem@outlook.com
Cc: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Jeff Johnson <jjohnson@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Saravana Kannan <saravanak@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38442-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:george.moussalem@outlook.com,m:devnull+george.moussalem.outlook.com@kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-remoteproc@vger.kernel.org,m:axboe@kernel.dk,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:saravanak@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mathieu.poirier@linaro.org,m:p.zabel@pengutronix.de,m:devnull@kernel.org,m:krzk@kern
 el.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,outlook.com:email,qualcomm.com:email,mail.gmail.com:mid];
	FORGED_SENDER(0.00)[brgl@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_TO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.infradead.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,pengutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,george.moussalem.outlook.com,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A23356EBCED

On Mon, 29 Jun 2026 15:01:46 +0200, George Moussalem via B4 Relay
<devnull+george.moussalem.outlook.com@kernel.org> said:
> From: George Moussalem <george.moussalem@outlook.com>
>
> The Bluetooth subsystem (BTSS) on the IPQ5018 SoC supports setting power
> modes which are required to be configured through a Secure Channel
> Manager (SCM) call to TrustZone. However, not all Trusted Execution
> Environment (QSEE) images support this call, so first check if the call
> is available.
>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


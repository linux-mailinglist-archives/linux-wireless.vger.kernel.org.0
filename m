Return-Path: <linux-wireless+bounces-37514-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8DW6JvWmJmp5agIAu9opvQ
	(envelope-from <linux-wireless+bounces-37514-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 13:26:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DAE655AED
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 13:26:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kqjKgFkO;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37514-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37514-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B02E304D256
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 11:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE27366559;
	Mon,  8 Jun 2026 11:19:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175B8365A1A
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 11:18:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917541; cv=none; b=KBta/kmeVFxNRsRpH6p78hwMMoDTsw6FZt6AxAC2z4JB8mYkCmBJPfQs7WG2nj8EAvur11r2kcbf14wHs3Jnd7D2WKpMuDeTFJruX5nbn52fwPp15iHsTZCp/k7al90BoyaE+F9nUyjZVQ6Q5mLk8pzAIu09/XdWoMZiY32+VZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917541; c=relaxed/simple;
	bh=DPpaot2Svx2MSbq7KY9ZMt5/x26NfewXAR6zENf8kbQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xky7n/MMVQgAAjdFTpDLILJo9Lj56N+Ol/05EuZR8yUwjslObQZ/yB6UbMFVpZLcqnlRQF2+PrYHIbF/Azv4RcnzJtW42wI6DcvrCUjS67vxjJM6zCMqAxSsuG/HC/t4JKyjumkRER7o0O7nlDWyoINrXq7ds0AQP0+cNjIWVgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqjKgFkO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC181F0089C
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 11:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780917539;
	bh=DPpaot2Svx2MSbq7KY9ZMt5/x26NfewXAR6zENf8kbQ=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=kqjKgFkObqfwVvcVXJkmpZpX1TkQLYU2+UZlp+tpOIg2EQzD0ciQMwI5eKqP5zNNy
	 1MnoAYN3hwHkJNojge4fY+NqquZfjcy1RFbVwG9S5vYZVoS7zIvnokjvKHsnZsatXL
	 rkNjgnxHzxM+NNcXGGfbHCf4YLS0NUpvgH2u75haXaazraTVOdDCnaGnrs9qfizMBr
	 OCXo4+GKRuOhfmzK7xphPdiBEIcJ5D7IVc10xgYL1LHgOXKW5TfbZJEfdl7/0qO9m9
	 EuWqidU/SAy83NacJkFbC1yw+bkT0wGwguF7deGgd3UfJtYIBpIQrvdTVsXuRdl+QS
	 +EgFvL7SjvVuQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa7a70c0aaso4221726e87.0
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 04:18:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ81TpDqyNwigQAoAStPO8RdVJQCmQEGuKlMdo6wpYgjPkcNwZivMAHiNA7kusE+lHU9aNlqiT9NtaNzfYKLTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOYzyTUwwkJQeIngVo1v/hEstDlwYDqepkYT2N5Xq2s1xr2Z6w
	1aSPbQb5FZ9ejmzQRUm4zHomR257HgIQjJUsESlKRHCgxEvMJ2z0otFVeKSWmGm9NVKtAvUhFYd
	S39wfOAZ7aUhLV8lOvM4GDo/Gc/mhHfDzNwMNOM6Yrg==
X-Received: by 2002:a05:6512:61d3:10b0:5aa:6b85:85cf with SMTP id
 2adb3069b0e04-5aa87babf3bmr2724481e87.10.1780917538408; Mon, 08 Jun 2026
 04:18:58 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 04:18:56 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 04:18:56 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260608-block-as-nvmem-v3-2-82681f50aa35@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com> <20260608-block-as-nvmem-v3-2-82681f50aa35@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 04:18:56 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeyOS=ngzVcu9zHN1g2W60GXHuZgSFozCTSVb1cGxJwMw@mail.gmail.com>
X-Gm-Features: AVVi8CevzSi8FWjqPtdJGMMjRNFkh5D31R7JAhStRKSOzvhr_7JJA4oBvY-YP1c
Message-ID: <CAMRc=MeyOS=ngzVcu9zHN1g2W60GXHuZgSFozCTSVb1cGxJwMw@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, daniel@makrotopia.org, Ulf Hansson <ulfh@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saravana Kannan <saravanak@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37514-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:loic.poulain@oss.qualcomm.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[brgl@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,makrotopia.org,kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,qualcomm.com:email];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1DAE655AED

On Mon, 8 Jun 2026 12:50:39 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> Document the NVMEM cells supported by the ath10k driver, the
> mac-address, pre-calibration data, and calibration data.
>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


Return-Path: <linux-wireless+bounces-34422-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFm3OCuO1GklvQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34422-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 06:55:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DB23A9C34
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 06:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 028C63007BAA
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 04:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0199934CFCB;
	Tue,  7 Apr 2026 04:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="og8fhcTr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC19E344D8D;
	Tue,  7 Apr 2026 04:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775537702; cv=none; b=OJVZVTuFn/+V4tQi+eyjLkJZpvOlVSFElIqcZPYwdBKf0mxRksYxpDN6W7TGDneoCQKMp/5NOzDM9cuq6x5OsOBw0iyYthSLDJRxk7AgPkBYNlJXGbowpC1JglMpXTJiklrsXreHk+EqKy827Tw/eoUifxMROaR39J657Knn31E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775537702; c=relaxed/simple;
	bh=rvu7/o0Lwq7mvoGpGDMuVDAnB7mMlRjy9d5tc7U+Cb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPHX+qalhQLEAB2+ra1xXAjTnTBXIYGWYVyGkeJPGER6wr5dDd0CBpcVRT7EMZJDfItccG6L+Ur045mZgNf4eJQJwsfmcPPqu3J1zMP/zdcQk6UqWfVam5DLCIqhSaXWbLeKKbQbq7LYo18hB7Rae9ILxF/zNFM/g+drjXdfed8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=og8fhcTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60815C116C6;
	Tue,  7 Apr 2026 04:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775537702;
	bh=rvu7/o0Lwq7mvoGpGDMuVDAnB7mMlRjy9d5tc7U+Cb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=og8fhcTrcSW1XpExdd/a68mQ3sOlxr3SXLyjG8HBdY4XWYM29iTLx0Vs0oZzLQBYD
	 tu/RPZiAfSuTwJv5JHbdFaiitpZ6bXxgjdlLLxffWjK89/+jrNtXEyaJ4DJU/d0LCi
	 R6uKK10Vn0UY5G1a0lvKWQphTQ5vpl4v7DMcIZPNotI5UlcQAmshX1P/Wvpvltcgkl
	 vD400kR01f5mLCkLuTrZxTVTIz3eLkCsqiEBguYacQ0aKOGIUaWkZrKUIb0uWeIiYs
	 L/vTx3jbOsZk2PnifHxjEUKls3C4t+Wnbflcd+lJMRWwJLFmxogFFi7/Fue/xF+WPg
	 BLYdUjWFdKV2w==
Date: Tue, 7 Apr 2026 10:24:44 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-remoteproc@vger.kernel.org, konradybcio@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	robin.clark@oss.qualcomm.com, sean@poorly.run,
	akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
	jesszhan0024@gmail.com, marijn.suijten@somainline.org,
	airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
	dikshita.agarwal@oss.qualcomm.com, bod@kernel.org,
	mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org,
	trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
	pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
	tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
	srinivas.kandagatla@oss.qualcomm.com,
	amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
	op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
	skare@qti.qualcomm.com, harshal.dev@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v3 00/15] firmware: qcom: Add OP-TEE PAS service support
Message-ID: <adSOFCL26y5qt1Cu@sumit-xelite>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
 <adPLx3nCBb8IHz2b@baldur>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adPLx3nCBb8IHz2b@baldur>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34422-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0DB23A9C34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Bjorn,

On Mon, Apr 06, 2026 at 10:09:27AM -0500, Bjorn Andersson wrote:
> On Fri, Mar 27, 2026 at 06:40:28PM +0530, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Qcom platforms has the legacy of using non-standard SCM calls
> > splintered over the various kernel drivers. These SCM calls aren't
> > compliant with the standard SMC calling conventions which is a
> > prerequisite to enable migration to the FF-A specifications from Arm.
> > 
> 
> Please get our colleagues involved in this discussion, because this
> non-SCM interface does not match the direction we are taking.

I thought I have already involved folks from QTEE perspective (Apurupa
and Sree) actively working on FF-A implementation aligned to this
interface. It would have been better if you could let me know where is
the direction mismatch here. In case there is a better alternative
design proposal for PAS service with FF-A, I would be happy to hear
that.

Anyhow for the legacy SoCs like KLMT, we really don't have any
alternative but have to stick to existing QTEE PAS design with OP-TEE
providing as an alternative backend. Surely we want to support loading
of existing signed firmware present in linux-firmware repo for KLMT with
OP-TEE being the TZ.

-Sumit


Return-Path: <linux-wireless+bounces-1946-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C76982E265
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 23:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D39DB21FB3
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 22:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FC21B594;
	Mon, 15 Jan 2024 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kVv7EoPO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2A51B592
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=lZEioVbZXprblS4KV2XV5SwTDf0L1hPGjBNR3PmClu4=;
	t=1705356021; x=1706565621; b=kVv7EoPO4Ps8+42m6xzfyRLxBpyY8KYi2Qyx5Xm7CwGNEQz
	kUBOrv/jd+1NEULJFq+peZna6VfxFez3dq0gk/yIozJ4HlN2u8E/8RNGwT+oCi2u3/IeXB9InGY4S
	/ChVXVScnM1PDanVNkYibItasmzRdtvMbnGCXAVVcPd0EFmbLXUfa2IBut9PsCTbO49BgRmPW8l77
	BY4ieuRiZAnvBUn6BnLqIoeGUPSu0jkYYO83jExmkVSLVfKZZB2zo6GkPws6yWDRfYFXdpAogbkYF
	Qc5KWpA9dwNWY+g44c+4FiybkCNZFMsaN6BebMoa5o7kd0/B9EGThCWcSIghFHsA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rPV0E-00000003pNL-1DBs;
	Mon, 15 Jan 2024 23:00:18 +0100
Message-ID: <88ad7e8849f7b29826ddf922734997d73539b21d.camel@sipsolutions.net>
Subject: Re: [PATCH 5/8] wifi: mac80211: disallow drivers with HT wider than
 HE
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, Kalle Valo <kvalo@kernel.org>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, Gregory Greenman
	 <gregory.greenman@intel.com>
Date: Mon, 15 Jan 2024 23:00:17 +0100
In-Reply-To: <b1046a3b-8c29-aa64-2954-adec6c5d9bc9@candelatech.com>
References: <20240111161746.3978601-1-miriam.rachel.korenblit@intel.com>
	 <20240111181514.da15fe3214d2.I4df51ad2f4c844615c168bf9bdb498925b3c77d4@changeid>
	 <87wmsehf3d.fsf@kernel.org>
	 <aae05a63171cf0f3c81dedc24d3b0a558ce530f5.camel@sipsolutions.net>
	 <b1046a3b-8c29-aa64-2954-adec6c5d9bc9@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-01-12 at 11:58 -0800, Ben Greear wrote:
>=20
> I tried backporting this patch into my 6.7 tree.  An mtk7915 radio system=
 blows up badly
> in this case.  Likely this is mt76 bug, but also...it used to work and th=
e crash doesn't
> make it very obvious that the above code is to blame.

Yeah, hence my comment about kernel developers hopefully being able to
figure it out :-)

> mt7915e 0000:06:00.0: mt7915_register_device failed, ret: -22
> mt7915e 0000:06:00.0: mt7915_pci_probe had error on try 3/3, ret: -22

Felix says this kind of retry logic doesn't exist upstream, maybe you
have some delta in your tree that's making it crash?

Also, from what he says and looking at the code, it should register with
HE 40 MHz capability set whenever has_he=3D=3Dtrue, so also here, do you
have any non-upstream changes that could affect it?

johannes


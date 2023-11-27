Return-Path: <linux-wireless+bounces-130-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8467F7FAC71
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 22:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5ECD1C20F4B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 21:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5284596B;
	Mon, 27 Nov 2023 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dwduNDRi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D871A2
	for <linux-wireless@vger.kernel.org>; Mon, 27 Nov 2023 13:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XKLjnlY9Du+A0CjdLlQjKJ+lZ5W3gM/4bfbQFU2dOrI=;
	t=1701119813; x=1702329413; b=dwduNDRicbF9hN0oTtTS7oqyH4jLpSF23yDflVWoJzdtIQ9
	se1Qar9xWfKb+neoTySxmFvHspMGaRvfPwDN+xHzhkI9w0A8CkKvI6Ea2C66R+DGs7ca0sn13G2Tr
	wpPKXsMr05mwlrfwXiAclDHth0D4o+3684R8GKwBp+4EbEWS5CY1cyzf9wfII1DK6o4DdSAOudtfR
	OjPoKavhOtOKEucLx44Q+STy8bZXQVOtnR44JcMx/aceUZufCZkTu838Rv8y4l0LeLA6OkbuI6+VR
	jL6e+5JsyzEdzXjXTG52v8acfIv34kEhnggET1z0Smlm6ox6ODESXRUO8TUv0m4g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r7iyJ-00000006Oq2-1z7Y;
	Mon, 27 Nov 2023 22:16:51 +0100
Message-ID: <0f2e4781cbc994bacae6fe8f56b9aef9fc66bc1a.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: use __counted_by for the rest of
 flexible array members
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	linux-wireless@vger.kernel.org
Date: Mon, 27 Nov 2023 22:16:50 +0100
In-Reply-To: <20231127112601.42636-1-dmantipov@yandex.ru>
References: <20231127112601.42636-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2023-11-27 at 14:25 +0300, Dmitry Antipov wrote:
> Following commit 9118796dfa67 ("wifi: mac80211: Add __counted_by for stru=
ct
> ieee802_11_elems and use struct_size()"), use an incoming '__counted_by()=
'
> attribute for the flexible array members of 'struct probe_resp', 'struct
> fils_discovery_data', 'struct unsol_bcast_probe_resp_data', 'struct
> ieee80211_mgd_auth_data' and 'struct ieee80211_mgd_assoc_data', as well a=
s
> 'struct_size()' helper to allocate an instances of them where appropriate=
.
> This also introduces reordering of statements in 'ieee80211_mgd_auth()'
> and 'ieee80211_mgd_assoc()' because the counter field should (is better
> to?) be adjusted before touching the corresponding '__counted_by()' area.

For the record, regardless of the commments from Gustavo, I'm going to
put this on the back of the list because we have various things in
flight now that touch these areas, particularly mgd_auth/mgd_assoc and
related code. Not convinced that it's worth making more work on other
things for this, when I don't even think (released) compilers have
support yet.

So just FYI, you might want to come back with this in a month or two
when hopefully other things have settled.

johannes


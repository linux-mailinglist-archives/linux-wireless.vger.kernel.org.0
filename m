Return-Path: <linux-wireless+bounces-7-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 836937F68FC
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 23:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C864281241
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 22:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA442FC4D;
	Thu, 23 Nov 2023 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uyEeSJYE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE026D54
	for <linux-wireless@vger.kernel.org>; Thu, 23 Nov 2023 14:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=mP8Wq6CXAMqmmi4Cc2dRJlLYRuw/4wvj4uk52hARVCc=; t=1700778474; x=1701988074; 
	b=uyEeSJYERZBZrETKMLCry62pGLFDJepvpMMDtQN/4TFRa/uQBYCXkKWL4M5pjF92XvGya89aSBe
	djt5MMHDmUHNOetRw+TcUBCc6P5+0WaNSVGib4zgrlaW7TT4zRM2I+cca/2neATpfwYQ1K0jA+m2t
	W8koakGICDtFpTul0GlIxitHgpb7qbSBmaxevymW9Xs4VV4oub6HKJm2lFAhG3+hZ1+Of1VckxqE6
	s7uY74ePbtHlWIGDAua59LwUpE6newR2wZf1KYAVj0/0/wDdUarIEVYhfAYMJ5lEf/s2drWtyqZ3R
	PKC5lpP5MMdvWafA0grhWiVZZbwoodzUfO7w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6IAq-00000001Y53-1UQi
	for linux-wireless@vger.kernel.org;
	Thu, 23 Nov 2023 23:27:52 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [RFC PATCH v2 00/13] refactor and wider-BW OFDMA support
Date: Thu, 23 Nov 2023 23:14:37 +0100
Message-ID: <20231123221436.143254-14-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Continuing the work I already began in [1] (but hadn't so far posted
a v2 of), this shows what really was the purpose of me looking at it,
which I had alluded to earlier: supporting wider-bandwidth OFDMA in
mac80211.

While starting to work on it more after the channel request, I saw
that the code that determines the channels etc. in the MLME is not
really very amenable to the kinds of things I needed to have here,
so I've done some major refactoring of that code, that's in patch 7.

Note that patch 5 breaks two hwsim tests, but the reason is that the
code in wpa_supplicant doesn't take the HE/EHT operation into account
when calculating the expected throughput, only the capabilities, so I
believe that's just a bug there.

Note also that I think that patch 8 shouldn't be there, an AP that
drops any of HT/VHT/HE/EHT operation while doing a channel switch
doesn't really seem quite reasonable to me. As noted there, that's
affecting 8 more tests, and I've split out the workaround into this
patch to show more obviously what's going on.

Also, the refactor patch (patch 7) introduces a FIXME for puncturing,
as it doesn't configure it properly from the start, but will then
only reconfigure it when the first beacon is parsed. There were some
additional patches about puncturing [2], and I need to take a look
at those. I believe patch 3 there is already covered by what I've
done in my patch 7 (partially it's the same), but I probably still
need patch 1/2 in some way, and of course the driver patch isn't
related at all.
However, the right fix for the puncturing is to put it into the
chandef as Aloka had originally suggested, but I questioned and
somehow managed to convince her that it shouldn't be - I was quite
clearly wrong about that. I already said I'd need to move it into
the chandef, and at that point the FIXME in this code basically is
addressed automatically. I didn't want to introduce any workarounds
to this code instead.

So ... yes I realize that these are some big changes, but I tend to
think that they make the code better to understand/maintain, in
particular the 'connection mode' struct that's easier to track.

The hwsim tests seem to run cleanly apart from what I mentioned
above, although I have 9 tests that always fail for me, and for
some reason I cannot run the wmediumd tests right now.

johannes

[1] https://lore.kernel.org/r/20231109003040.4b25d42b8b14.I60d093b2fc81ca1853925a4d0ac3a2337d5baa5b@changeid
[2] https://lore.kernel.org/linux-wireless/20230928055022.9670-1-quic_kangyang@quicinc.com/
[3] https://lore.kernel.org/linux-wireless/20230928055022.9670-4-quic_kangyang@quicinc.com/






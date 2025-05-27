Return-Path: <linux-wireless+bounces-23443-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9B3AC4AC8
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 10:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C81189EE9C
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 08:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFB82475F2;
	Tue, 27 May 2025 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vbOtHGmK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAB2142E6F
	for <linux-wireless@vger.kernel.org>; Tue, 27 May 2025 08:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748336122; cv=none; b=PNAnsCFC8mTZoim5qvVt2LaaYEmq9dc+i7s1jgZait/iLA/Q4oW2Ty0wedYPuxAwzxb8IAE6KQImXyBWphkXASASvlFaPz9wJvtsas+0IcX1+yVJHw97UxzhQZx7ZvOC0UKrDTJNlCT71pIw42/AVQruhoiwmO3TqxTG/iZ5Iw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748336122; c=relaxed/simple;
	bh=2xK9T0ddqUEV3qTezXNqKNRLnNH3egry79QuEHiLIJ4=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=D5Cu+/fjS0NJ1saBavXlg6VR2lO1Sjq4fcZC2+BUjzPU4+29KFjbMS2/JMMjntnjv+BJP9RAfK3LqkztY8kC4b2fh5QRRkqpR3l98czzGHhhd4V62uUbnbdfRT80AMzfi6Hi6wFrjocbtoIjmjiwXXHEKl1wc2wk4ZSTPRaJKvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vbOtHGmK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=2xK9T0ddqUEV3qTezXNqKNRLnNH3egry79QuEHiLIJ4=; t=1748336120; x=1749545720; 
	b=vbOtHGmKH5SnRxEL871nipi0B8LB9vDZaTH1Ky4QqUc+RtPZYKAIbUjvgdwIp33wFKZLUmo7BnW
	7LvRepMG6GNKBnZIfDaTg9SFo2Bna83jswq/+xJ7qOaHfKWFXvZYgOU/vgDgIbBVvRb4uKLEG9VJm
	ObwSrcI5pjWlOnUEaOmlvP8hU15Auk9wZ1MfLv+0ADqWv9eI53rcEzg71GSKX3ssdx+1HGKUigLFl
	ELlvrGOvebjTfhzsVVdyBvNX4q9FwBVSQnfAwRVfkX5KDCjpwiaj9kD3W+qfM8yu27eB3et3og9qW
	tE5aGeJyj4XGfPkOqD1nPIjD5VBxcIKXpt/Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uJq5c-000000005XH-0iw9
	for linux-wireless@vger.kernel.org;
	Tue, 27 May 2025 10:55:16 +0200
Message-ID: <01da63d05c861af5a71eb18d117341b5f7c7628f.camel@sipsolutions.net>
Subject: CI results
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Date: Tue, 27 May 2025 10:55:15 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

So I'm probably preaching to the choir, because those who don't pay
attention won't read the list either, but still ...

Please everyone look at the patchwork dashboard:
https://patchwork.kernel.org/project/linux-wireless/list/

You can filter by yourself, e.g. for me:

https://patchwork.kernel.org/project/linux-wireless/list/?submitter=3D90
(but that list is empty now for me)


If you have _red_ items there reported by the CI bot, I'm most likely
simply not going to apply your patches. I _might_ if I care enough to
fix the issues. This also depends on the timing, if it's with a lot of
time left (like right), then there's plenty of time to resend.

If you have _yellow_ items there reported by the CI bot, I'm going to
read that and I might decide to fix small issues such as spelling
myself, but I really prefer not to, it makes things go smoother. Not all
the yellow items always make sense, especially checkpatch.


And I guess it needs to be said, but since these results are public, I
feel silly manually requesting that people change the (obvious) things
that were pointed out by the CI bot. I think I'll just start marking as
"changes requested" semi-automatically.

Ideally everyone would build an internal workflow that checks this
before, even the NIPA bot itself can be run pretty easily with the
docker container (we still do that internally before sending to the
list, even though we run the list instance now as well.) But I'll grant
that not everyone can set it up and have enough hardware to throw at it,
that's why the public version exists.

Please? :)

johannes


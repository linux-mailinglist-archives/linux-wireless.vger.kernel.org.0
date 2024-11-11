Return-Path: <linux-wireless+bounces-15177-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6C69C3D93
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 12:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F2E1C2198C
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 11:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA7418990D;
	Mon, 11 Nov 2024 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBHMwjMY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A89139578;
	Mon, 11 Nov 2024 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731325144; cv=none; b=rl99vYnWkRiSzfuLECV7Z03roFhTXDAKpxilEaI+lbnGHOjBEvOeNc9wWcmjQso0Z3nblOHGdwVw1C8JyWrIcjSBnfGR0LPBnvuAq4qOHmxDedX0aA8DwuYrvyufzy1R3bEAfNkkg5aX5WSg2+F9RSU1tI5wtMq3Cu+I+Z4yAfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731325144; c=relaxed/simple;
	bh=awS5dN+X4Ie3viCfpwkaNH+GZOItv8oSj0ZeFRm8cNg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ur/lumuLHcXDZ56FCGzywSA97TOufZuQmxn74v5+33I9Bnah0Jat9xUMwukGfO4UG/xU9/W1X4gu8dVCJTatG69cqp+t4QKzIIERio8vTOq3MDv7neAgSnHLTaLsambn95eaUSZSl+cAOdhm7AdpA+XqanvtiR1WLI22z0k9MEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBHMwjMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12000C4CECF;
	Mon, 11 Nov 2024 11:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731325143;
	bh=awS5dN+X4Ie3viCfpwkaNH+GZOItv8oSj0ZeFRm8cNg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=MBHMwjMY8Bewc44C302prC+Tn3iwhfcwLBcZsKDXtleyvpIAL554HS67L76xDdVsb
	 zSVlfSoj/E4Y1aNpM93fHnNteD3FkPwwIHiZDZCXQhMwhiCWvREYb0ynNxxMtu1vic
	 M1EhWEZLfSOvKMBgFXabrtxGX4fkqmz0PJttsay9exxJWfQLtgO+HHwIFBDck92jMT
	 rwUHvqvw0ta2zTGGwjttqk53D8BLhSGf+vQLEVlgHjj3btGhw5oyCTgXepFzBpcnF7
	 pfQyI7NIMFxgI/N/7iBj0PpqL9bDGB8eLTTYMUoon3JKJmOPW5LoY5wV73CYlDVhXz
	 STqU9WsFQzTUg==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Michael Nemanov <michael.nemanov@ti.com>,  "David S . Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  linux-wireless@vger.kernel.org,
  netdev@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Sabeeh Khan <sabeeh-khan@ti.com>
Subject: Re: [PATCH v5 09/17] wifi: cc33xx: Add main.c
References: <20241107125209.1736277-1-michael.nemanov@ti.com>
	<20241107125209.1736277-10-michael.nemanov@ti.com>
	<685d782d68bfc664c4fcc594dff96546ffc30e5f.camel@sipsolutions.net>
Date: Mon, 11 Nov 2024 13:38:59 +0200
In-Reply-To: <685d782d68bfc664c4fcc594dff96546ffc30e5f.camel@sipsolutions.net>
	(Johannes Berg's message of "Fri, 08 Nov 2024 12:42:59 +0100")
Message-ID: <87seryvw30.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

>> +static void cc33xx_rc_update_work(struct work_struct *work)
>> +{
>> +	struct cc33xx_vif *wlvif = container_of(work, struct cc33xx_vif,
>> +						rc_update_work);
>> +	struct cc33xx *cc = wlvif->cc;
>> +	struct ieee80211_vif *vif = cc33xx_wlvif_to_vif(wlvif);
>> +
>> +	mutex_lock(&cc->mutex);
>
> Given the way the wiphy mutex now works, I'd strongly recommend not
> having your own mutex any more - it's a huge simplification in a lot of
> places, and there's very little downside since everything coming from
> higher layers holds the wiphy mutex already (and almost certainly needs
> to acquire your own mutex.)

I can recommend using wiphy_lock(), at least in ath12k it made the
locking so much simpler. The more wireless drivers start to use it the
better.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


Return-Path: <linux-wireless+bounces-14970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70AC9BE37A
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 11:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA1B285E7D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 10:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1B91DB36B;
	Wed,  6 Nov 2024 10:05:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053151D359E
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730887551; cv=none; b=azyi2pdYNuBdwg737P1sI0kGKyVcWKc/LH+4tlQF3fZg16Wc2fATXJ+Kc1YWmgP4r1PnQTq+utogwo+uIK96d6EfjzPZ+gUUdnaWbWfQnSnhZBqInKCcXlTUs5sNW9hre8d4Eo0arja/d0OqpvpMcCsk8EVkpt7P2RpvP2Br41o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730887551; c=relaxed/simple;
	bh=TLTWLHmo++V8W770IMkakLxtca+XMNZElS3p8QFm9Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFluMwKIZFn8f78Z7Grt/3gAIqEnZkjwnY/RQlZBplKFeW0rjOz6rGSnrb55HH1+Adz0FFt0sWGVb2nfEaflPChVJD78Uougj//xg+kdMTUZ2UwJkod/upDbkjEC+H5Bk06+qpqThp4MQFhOEFy9iurtLMgqYgzlJWzoHTydpXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from [IPV6:2003:c5:970b:9290::32b] (p200300c5970B9290000000000000032b.dip0.t-ipconnect.de [IPv6:2003:c5:970b:9290::32b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 92041FA132;
	Wed,  6 Nov 2024 11:05:46 +0100 (CET)
Message-ID: <cf2bd918-f03c-4810-985a-b72635797f0a@simonwunderlich.de>
Date: Wed, 6 Nov 2024 11:05:46 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath9k: Reset chip on potential deaf state
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
 Simon Wunderlich <sw@simonwunderlich.de>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, mathias.kretschmer@fit.fraunhofer.de,
 Simon Wunderlich <simon.wunderlich@open-mesh.com>,
 Sven Eckelmann <se@simonwunderlich.de>
References: <20241104171627.3789199-1-ih@simonwunderlich.de>
 <20241104171627.3789199-2-ih@simonwunderlich.de> <87h68l96l4.fsf@toke.dk>
 <6688984.G0QQBjFxQf@prime> <874j4l90nj.fsf@toke.dk>
From: Hamdi Issam <ih@simonwunderlich.de>
In-Reply-To: <874j4l90nj.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/5/24 16:10, Toke Høiland-Jørgensen wrote:
> Right, okay. I guess that is also why you prefer this one to Felix'
> similar patch that was also linked from that gluon issue[0]?
>
> However, I still don't like tying this to the debugfs: if this is
> something that the driver needs to react to, it should not depend on
> debug features. Even if OpenWrt and derivatives always compile-in the
> debugfs, not everyone does, as we discovered back when we accidentally
> broke the driver when it wasn't there :)
>
> So how about something like the patch below - it keeps the "average per
> time interval" behaviour, but uses the same approach as Felix' patch to
> avoid relying on debugfs. WDYT?
Yes, you are right, I will update the patch to not depend on debugfs.

Regards,

Issam




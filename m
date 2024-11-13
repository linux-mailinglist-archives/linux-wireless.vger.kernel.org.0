Return-Path: <linux-wireless+bounces-15220-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114959C65A2
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 01:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C736B2886BB
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 00:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ADC1DFF8;
	Wed, 13 Nov 2024 00:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="NOYshMNV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2CB20ED
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731456067; cv=none; b=Owlm4m/o8lzAgBLSzAJOLq2uqM70Y25AbmuAay09/NeaQyuMUA+PlVUMub6re2xblPufD7oDwS99Di+NqXhYSrnu7dvQ8tjgQUca0kl0yTgPp0mlCod2QWRmOKgvBmVLC8ds3WlZy1VqmOUWdvAqAB4+Zal6ol9uOE6OGwwDudM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731456067; c=relaxed/simple;
	bh=FoGmaHNM63GqBq0BQy8qKOtath3he6N2gYMwzHPG5lI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=n51QyxUzkv1+ONvVVjJYlph2QQHh1A+7Mbr/mPZPKJJfzDN/iICaON2aQxmRo5ODLynZt7HPhQ59XkIVUdA3IEgMqJhDL+iOTIwlSlGxqvxK9CbIEgsI8fK3idQxjplROHu5+c/9mVDQqa6fvIcl7juiF8DfBtOfZXC/P9zR1G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=NOYshMNV; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7240fa50694so4893627b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2024 16:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1731456064; x=1732060864; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FoGmaHNM63GqBq0BQy8qKOtath3he6N2gYMwzHPG5lI=;
        b=NOYshMNVjSOTVgdvo3zfE6mXikzn4pYqNHipj0T21Z3Hebul9xRMKp7a+PtzsHjzKZ
         XalpWnvHO7XPWIqwHoQXHBVX9K7RF+rSzyQF9iW+lRslUFGXvpspzxj36JfvPnMILaJJ
         ClgMLJgafCGgmuBE5k1X0cmnHNG0enMQz9c9mlZD8wjOhxi8wcMf5DtcwcdAjpQBiyQq
         q/iPcgNsM4k/VdpGffIFODf3oOV6u5iYjUkC70Z4DzhYfGu8bZQnhBFOFMG1HNLGjoQn
         kNLzSSZadhtSSVvoVUVQx7Etq2EIHBbt20cykdaPXgR1UGzMpqFx46YUgsDb3qc9R72R
         0tWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731456064; x=1732060864;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FoGmaHNM63GqBq0BQy8qKOtath3he6N2gYMwzHPG5lI=;
        b=dc7kXROPQ1usdoqbkJa3nrEBkOfqzq3OKowiJXSC9IfgLz84QDK48LcN4gkJV8wkDQ
         baVp63+j5/GQF0BuynluDv9liRTCu54lWBj37k7QTDkAJB/lexnXJRDHOMY+pHHUOKW/
         mkNre9GuSuZRobJHIIEVlnUNqgrfJ9Yy3JkUCw5EhB4Djc3WvSfRNK6BI2rQNW89Udh6
         P7IaQ1LRl/xc/oSoVDm+BGn6lu8nD7kte6DYJNCwfkjxjgdMoSOOE+zEFUrj8B84KzjV
         FyagX6vzzJy0vRwPtxCuC2aLaPcVUR87pZ554ewlPZ4GsigAl0F5wvTLuDSiMmw/9atp
         8TKw==
X-Forwarded-Encrypted: i=1; AJvYcCUJBoBpuzwDxGLVCJQ1q7kFDPrHCl/q7Ce1sx8vcGa/qhM7tXq6zgzEO35SkwczaCUu7I+JhlJOZ3i4HHOCUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOZc4OtJkZRoEjDg0gnejmkDgY2mWlOuI1G+YXCGUpHMzGnVZo
	KzfsKF46x/u7ljAJq+zDbXFj5u2gLLKzvz+/vRfK209oRDgZ/iA7tSZHiz3BmD4GjeUyob2ZJwk
	3Lv5kzmhdB3y/4759WuO4rsI6maATJJqUTn/e
X-Google-Smtp-Source: AGHT+IEYm3xrjN3OhpDff0TCYzAQLcLBy7Ie7ujNcFbKW96oksbJ7FAxRHHehy6fUA3rjkmHB85DZUo8zI+0z4ZkvRQ=
X-Received: by 2002:a05:6a20:734b:b0:1db:eb2c:a74 with SMTP id
 adf61e73a8af0-1dc7037a94dmr1440958637.12.1731456063780; Tue, 12 Nov 2024
 16:01:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 12 Nov 2024 19:00:52 -0500
Message-ID: <CAM0EoMmoLXpz70sF6z301OccU-ghgNSOad9cQVhizipy-is-Lw@mail.gmail.com>
Subject: 0x19: Call For Submissions open!
To: people <people@netdevconf.info>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, Christie Geldart <christie@ambedia.com>, 
	Kimberley Jeffries <kimberleyjeffries@gmail.com>, lwn@lwn.net, 
	Lael Santos <lael.santos@expertisesolutions.com.br>, 
	"board@netdevconf.org" <board@netdevconf.info>, linux-wireless <linux-wireless@vger.kernel.org>, 
	netfilter-devel@vger.kernel.org, lartc@vger.kernel.org, 
	Bruno Banelli <bruno.banelli@sartura.hr>
Content-Type: text/plain; charset="UTF-8"

We are pleased to announce the opening of Call For Submissions(CFS)
for Netdev conf 0x19.
Netdev conf 0x19 is going to be a hybrid conference with the physical
component being in Zagreb, Croatia.

For overview of topics, submissions and requirements please visit:
https://netdevconf.info/0x19/pages/submit-proposal.html
For all submitted sessions, we employ a blind review process carried
out by the Program Committee.

Important dates:
Closing of CFS: Jan 17th, 2025
Notification by: Jan 26th, 2025
Conference dates: March 10th-14th 2025

Please take this opportunity to share your work and ideas with the community

cheers,
jamal (on behalf of the Netdev Society)


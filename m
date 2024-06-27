Return-Path: <linux-wireless+bounces-9653-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F0291A40C
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 12:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F901C216DA
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 10:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42BE1386BF;
	Thu, 27 Jun 2024 10:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="jcjLIB+7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BB013DBBB
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484722; cv=pass; b=IpfgvjrET8VrWrtn+V6SL6QTvTvazZ1m29UfZZEWxNkAjn4s4fGjKx7h2FadqTzW8IdJuxBNz/DLTQX43FIFyveuyMz2mRShgeLhiK3Cl+z3FZOubj4UJ41JZyPIpMAIJrEk1FPQM/S1wmjncBK3Y8S2FKJNrtx9g5qGOk3qZvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484722; c=relaxed/simple;
	bh=nWd20viaNewFzaX7DFUEK6fFfMwx0tYLBiUF+Tzu6+Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kRy65q+zV3XvA1yUGht3b+2O0lOQWrgu+krh4g5r0THxprj7NhKT7jvGCAw9RlJdwhGKlh9UKwuer9fsnoxZis1vHDStshVJSrJDZNfy96gfjBJuxhD2yWkpkmKsTLmyEwaui1CD0Nonu7qD0bLE1xW67aP0LxuW/PJxObVMt24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=jcjLIB+7; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: martin-eric.racine)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4W8w5l6R7szyVF
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 13:38:35 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1719484716; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=nWd20viaNewFzaX7DFUEK6fFfMwx0tYLBiUF+Tzu6+Q=;
	b=jcjLIB+7B1IMaNnqkfOcv0RM6XQR7e6zCmvnEeS+O09/L2ZFaEEZk9a9JwIT9lSDcWV1wK
	S44EDkgnP+BHKCEdT/B45Tt2cZQYlKQ0AwXtrAFnJwFJtSQioaKuOOPiwb9w3iMSLAigHi
	3xRWel93SUsi93Aoo76xEDLtxsl+4cE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1719484716;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nWd20viaNewFzaX7DFUEK6fFfMwx0tYLBiUF+Tzu6+Q=;
	b=XMd6aTO2u0eJnB6fTh8G4QgZ8kyMkLfyeB8oskaxjU2rWt39+6Di1diL2zibGL8nVBaTCy
	uPCol0SlM6rkkNmdWXbMWoqI7CL+sWg3cWgCQvQQOvprZMYHB95i63VabwgUz7ECQfRo3f
	VYPxd+F95d7IzTCnD1/OAfZZBewqfVk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=martin-eric.racine smtp.mailfrom=martin-eric.racine@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1719484716; a=rsa-sha256; cv=none;
	b=HE+IwUOFUgigrBplyoA/R7lPsJiFEaJT7ajrw3v+tMvk87Exio5DzIYqp/5DJqy5/IIGNN
	o2iXt08iiqbbSeeRL3cuxw/+wGWh5JpGmbeG15Lh+9Ny7FAGW0/s52YZFqKVjjbjQggNXP
	I/tqi5Cq7oa6NLda4g529oD7D+xgylo=
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-366edce6493so3145527f8f.3
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 03:38:35 -0700 (PDT)
X-Gm-Message-State: AOJu0YxBTzxup+G+Pb0DKi11c+SgLs1fWXRinTraqF4LyT1eaMWrso7o
	U504QPBsCkDi63D2+q6imFscVrjJbkcNIMRDB+m1m0LKqnT3gfGhVxBKFD6sacCUeV2XpMaZ/No
	w1CL2/unER7wxRfH/mEZ/M8/RrwY=
X-Google-Smtp-Source: AGHT+IGLhgD/Mk11sIBjkZLYvgAn85Q8nJzvqVPRMeJcz/05MNryhSbBoZF3ZUO+Js5m/MMH0ml2yzxpXvDJM1ejmvo=
X-Received: by 2002:a05:6000:1863:b0:366:ecd1:2f38 with SMTP id
 ffacd0b85a97d-366ecd12fb6mr9554596f8f.7.1719484715337; Thu, 27 Jun 2024
 03:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: martin-eric.racine@iki.fi
From: =?UTF-8?Q?Martin=2D=C3=89ric_Racine?= <martin-eric.racine@iki.fi>
Date: Thu, 27 Jun 2024 13:38:23 +0300
X-Gmail-Original-Message-ID: <CAPZXPQeJZ_1QtyePvM-PujoBRTbQkyewxrJ3x01ieBHi2A37hQ@mail.gmail.com>
Message-ID: <CAPZXPQeJZ_1QtyePvM-PujoBRTbQkyewxrJ3x01ieBHi2A37hQ@mail.gmail.com>
Subject: [iwlegacy] kernel oops
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Greetings,

As reported a while back at
(https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1062421) against
kernel 6.5 (still present on kernel 6.8.12), iwlegacy ooopses on
iwl4965 hardware.

The bug report contains a lot of auto-collected information. Please
ping me if anything else is needed.

Thanks!
Martin-=C3=89ric


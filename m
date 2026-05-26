Return-Path: <linux-wireless+bounces-36929-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMR8JiQQFmojhQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36929-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 23:27:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 122015DCB05
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 23:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9C0830406A8
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 21:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268ED3C13FF;
	Tue, 26 May 2026 21:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etwJapfk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA68D3C1F50
	for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779830580; cv=none; b=ue/so5fTHGUVyb7Bhbh0WLAHha9Wpai6H53WNko6mQnHJ6F5mEzcr5JpSTixX6GNgirooL++aUyOrjUVnoVA1RDQu9EBFf76DqIHuL8M+tKsDtX2nWjLpgRi4zpPxevpwBCjZEvvVy+gJbvwzaboABogw1eq0lzLHTUhH08PemY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779830580; c=relaxed/simple;
	bh=MliZIEyZF+cjr5tCFsvOUcyvGEDv7HTQGjwah9i0HJo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=uEVoC6y4b95tctysZSTMSXykZ9sQmIquguYgEoQt3kvfVSy4z08PRhhfd3Hbum5kkuWO7IGQ1vMvFFHsctuGpqQbykxrjMpWcGNOr0FLW5GJNVh8/cw7v5d6EnhQUO4yTdYzdWlGS0YeNI87sVX31ExPOg8npaL5OB26MsKSL/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etwJapfk; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304545f5206so6540219eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 14:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779830578; x=1780435378; darn=vger.kernel.org;
        h=references:in-reply-to:content-disposition:mime-version:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MliZIEyZF+cjr5tCFsvOUcyvGEDv7HTQGjwah9i0HJo=;
        b=etwJapfkFifuajroFdaKOeKiLh+4JioV0HxSBqCR9G/9j4FsU4XEclm3aXJnAupGFh
         D6mvw0VNr58XDCv+9FpVf4Uln6i3RPE6lBk39MQ9wPYf//aaxq6XlKjp3X5xtNHtYZpZ
         4GBgumcBMWQOBL0G1jEwGGSD4LdXQN++ljC+/TKUJM+7sdyspzsBzlRgPQQYioPWlChe
         JFXx72AsTR2yyp2zdDgW2JuDEVBhaMxXGIiA34X5V8ER6XMqhWA622xN9Bx8y0PiOH/4
         XQkLZ1r1kX3kfQu3ydSqIz+6NR6qa7WtKSjQWCRVsR8wP9eYRvm0a2T4iGbPg/VZc3g4
         0dPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779830578; x=1780435378;
        h=references:in-reply-to:content-disposition:mime-version:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MliZIEyZF+cjr5tCFsvOUcyvGEDv7HTQGjwah9i0HJo=;
        b=sPM/t+s48qgk4bbTcbjyEsKFypaJkTVue/Fnz9Ze15eUCskeSpkqpyB7LeFVbc+hEL
         g78+NP+WI+ksyz2leCD5LT3KgFB/l1Dl9fefO3PpuYEBIniSHmPRgU7r+qP9BkWMIxtE
         vdXGC9V+QHjru5S7lF3mui13ddTd4Rg0zoa786upCH4Oq0YIOzCziE92bCoWdTgTSaAY
         dFxsGQqwn4G9PiXOnitvHTanarkhk79zi8aCWk8GhwLHYL75YOUq6gBn0tpwPBbeiB1k
         go+Zl9FDsX1YQ0U+xUNc9fRhqEdgF81Xq6+52kEK5CAkupdOAteuqabxhXABuglVUlYn
         FwqQ==
X-Gm-Message-State: AOJu0Yz6Dt2F6EGk6xSB+1sZ8v7w4rGtAt647nzBzWLxnqb/+kWEuf5n
	skPT4VKbQQsU+9lQ78QGPTWKxR2w8PIoqqrIzqJOQc/sz4z/iAI1yG2vv0axPN3u0oDNuA==
X-Gm-Gg: Acq92OHIxav/BanK112+0aNoV3s1hPEVnZkoDHxjbdQNrGGMy/fGtmZMv32XsJeNM1b
	L9orluy4FrrN1UEEEfXjIjH1Z6L+Oq1d8QrZFlZWi2rhkSR55JxfAmr/v5IZZLW7/eOpjzdtKax
	NUzAcxrBqm/ZeakG1FbL/6DCo4ttrjxx+mk5DZcqJoS27LqrZNQfufoTQCHQ3xCtHVdE5j3nLvZ
	oH4gEFY9GSPOJze1qDz/VnYqe6RDJJkWligha5N66QRFkOc+5/GqfzZ/FhAgmpbOVOv7h3sk1QX
	l4tCBCP08t+CprD7mb/XtUHU+EjuvFaCYYpe2znyGcLNSzYOUKwAKjBo9RwBc3uD6feK5uCqJe+
	pUjRTH2aZUaRbmw4tdE/OtffgCAnzoo2PrrIrgWBdHleNrA/7VNcy37eLQFtZnKrYgfgToW/qQj
	RtgC5h0+rajsG//lCsRNBhznUhPnRYfds8nMyRRQr5gzk=
X-Received: by 2002:a05:7300:6920:b0:2ea:4228:ab11 with SMTP id 5a478bee46e88-30448fd6079mr8891943eec.3.1779830577830;
        Tue, 26 May 2026 14:22:57 -0700 (PDT)
Received: from wico-dev.wnam.ru ([23.95.253.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm14592570eec.13.2026.05.26.14.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 14:22:57 -0700 (PDT)
Date: Wed, 27 May 2026 00:22:53 +0300
From: Ruslan Isaev <legale.legale@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: sean.wang@mediatek.com, nbd@nbd.name, lorenzo@kernel.org,
	ryder.lee@mediatek.com, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] wifi: mt76: track rx napi ownership for cleanup
Message-ID: <ahYPLdcoyMmzk3WN@wico-dev.wnam.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahTdpNQp2va_xTVR@wico-dev.wnam.ru>
References: <ahTdpNQp2va_xTVR@wico-dev.wnam.ru>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36929-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[legalelegale@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 122015DCB05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sean and others,

Tested on:
- MT7915E (PCI ID 14c3:7915)
- MT7981 WMAC

On both devices, the Wi-Fi driver module unloads cleanly without warnings
or errors.

Regards,
Ruslan


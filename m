Return-Path: <linux-wireless+bounces-24095-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB74BAD9623
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 22:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B56F3A549D
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 20:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3891F37D4;
	Fri, 13 Jun 2025 20:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="byT29Vny"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEFC1E7660
	for <linux-wireless@vger.kernel.org>; Fri, 13 Jun 2025 20:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749845971; cv=none; b=alnWqVHyiYhz8tUI+N3uCpsH98AX8nIvUx8Dy6c4emZDSmJRugBjwOZ8wFZtahZTYQf7MK5knGi8JmtFy64R+IUz1mrThYUntpZbbKYRvYGavQhHvhwB7zqKzjWFdm5Jxq019jYmU2PL1DnDXypbtTVwbq23lXfQvigzgOM6wB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749845971; c=relaxed/simple;
	bh=JuFv2nb4lv48/xPOzIQ2KSTK9/ZqXJZT7GvaMVxA7a8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dsPd4w+43ZQF7XbOaLPeynuIUJtKuIPcwWRT/lRDxpav7j4tXCwyy2L+Z17GRUA5uCiRb9eBnsPkP71ejlZ4lNNZUhiKFICzshzBpg+YzxXZ4pJQslcQTeezxxMOCucVeX03MyEMxLMkDS7+bCMX69RYKuP/EfhLUF7b3QG4zaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=byT29Vny; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.3])
	by mail.ispras.ru (Postfix) with ESMTPSA id 1E5B7552F53A;
	Fri, 13 Jun 2025 20:19:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 1E5B7552F53A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1749845958;
	bh=jNJ3RuCweL4rOMOeGnGEVFJ5wDzvqHSeKuUsJbx98y0=;
	h=Date:From:To:Cc:Subject:From;
	b=byT29Vny3VGd87J3HdtyDs958D5JhtDzjNxWHi+1QmbfBqgsiprNrtL5+g4BznheT
	 i5VZA59eZdxwW59Mq6ANxzEVIv6x2CB3w7Iq8deyr/gnGX9VnwLaqmTuQc7su+J87A
	 KSb8tU/IBfrGJedHShiy+EpwAUAPkzO3CCXjrnqk=
Date: Fri, 13 Jun 2025 23:19:17 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Christian Lamparter <chunkeey@googlemail.com>, 
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: carl9170: do not ping device which has failed to
 load firmware
Message-ID: <y4ufvifcearf75qds5hlro3rfiadwfwlixz5xg3w6jjozk5sdg@7yyfsdvyehon>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Dmitry,

Dmitry Antipov wrote:
> Syzkaller reports [1, 2] crashes caused by an attempts to ping
> the device which has failed to load firmware. Since such a device
> doesn't pass 'ieee80211_register_hw()', an internal workqueue
> managed by 'ieee80211_queue_work()' is not yet created and an
> attempt to queue work on it causes null-ptr-deref.
> 
> [1] https://syzkaller.appspot.com/bug?extid=9a4aec827829942045ff
> [2] https://syzkaller.appspot.com/bug?extid=0d8afba53e8fb2633217
> Fixes: e4a668c59080 ("carl9170: fix spurious restart due to high latency")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/ath/carl9170/usb.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/usb.c b/drivers/net/wireless/ath/carl9170/usb.c
> index a3e03580cd9f..a0bfa0c477ee 100644
> --- a/drivers/net/wireless/ath/carl9170/usb.c
> +++ b/drivers/net/wireless/ath/carl9170/usb.c
> @@ -438,13 +438,18 @@ static void carl9170_usb_rx_complete(struct urb *urb)
>  
>  		if (atomic_read(&ar->rx_anch_urbs) == 0) {
>  			/*
> -			 * The system is too slow to cope with
> -			 * the enormous workload. We have simply
> -			 * run out of active rx urbs and this
> -			 * unfortunately leads to an unpredictable
> -			 * device.
> +			 * At this point, either the system is too slow to
> +			 * cope with the enormous workload (so we have simply
> +			 * run out of active rx urbs and this unfortunately
> +			 * leads to an unpredictable device), or the device
> +			 * is not fully functional after an unsuccessful
> +			 * firmware loading attempts (so it doesn't pass
> +			 * ieee80211_register_hw() and there is no internal
> +			 * workqueue at all).
>  			 */
>  
> +			if (WARN_ON_ONCE(!ar->registered))
> +				return;

Is WARN justifiable here if it concerns handling a predefined error
condition?

I mean, yeah, it avoids a crash in the completion handler but kernels
with panic_on_warn - the ones which Syzkaller runs - will still stumble
here for no reason.

>  			ieee80211_queue_work(ar->hw, &ar->ping_work);
>  		}
>  	} else {
> -- 
> 2.49.0


Return-Path: <linux-wireless+bounces-21000-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 200FAA76473
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 12:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560A71885071
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 10:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A781DF72E;
	Mon, 31 Mar 2025 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BLJcVXfd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D731DE3A8;
	Mon, 31 Mar 2025 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743417779; cv=none; b=MHr48vGSvlI4leJaBAL02/x1XnB5Ev98qgsd1ygKUZc0YjAPCkRBkZeqRnDi3K7AZmJ5bL0JlQcRj0Y1upIWDFiugPi5UahzpGS8xYNUjPuubX/aoU0shlprYz+ntRyQ4xqkq7rOfTPlOpny+S/7gBqh5NAER3JuOuJJZdhuha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743417779; c=relaxed/simple;
	bh=PP2nLbUR4K+BHOjN3x6gO7ihm2saogOHP8pqQhFxx5o=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=nVVqd1tmZE90vdXqM/f6GFEH3YzHj8+LcK+qFC8Py+z/gigUCXScU0DUd66751x9R0OBoHWZwfeGnYARTjukOlDPcfWqaeSLZSp0Avk9iAm+wBC+Pv4Kyy3mwFpAHcdUTeUgZm8l1EUo9TlJU28Y4g08PfH9X5xFGrqqfOyZua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BLJcVXfd; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743417737; x=1744022537; i=markus.elfring@web.de;
	bh=9roccz9Qx+blLyXus8t6DHy/uRVh48jXrCw8kRAg0H4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BLJcVXfdn7F6c57YB2ZHtWJofsXQswzqhogdQmbP+S2McdbvUNMcjV61uqmjoffb
	 IkafM+0es/ktZVqRxHvx/2M6HDYuHsd01yLfsldBUAK5i0DR+8vPtJ7d+MBQwZkSU
	 i9wtxNez83kkOACxSLhqMrYtcXsPrO2fJgjxlZTijTKHZlnoDugIy9HCSWnp3PJGk
	 3YtvAmkk9hUi/HKzvBUeD/3Cxpg0xEIcHp3F8hUu6XsMz0+0S2zNF+cpB0WSn4l1i
	 KoUIO2cdFok0CbORB9jElKjItrwKdJ7muYq0vDID8fERgrVH7z3+7ldGbUeQFPFNU
	 3TAqevX4wxcaVoVsKQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.37]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRk4e-1tVxhr1N4U-00TWSO; Mon, 31
 Mar 2025 12:42:17 +0200
Message-ID: <c29ec6bb-231d-442d-86fc-a767d45a150e@web.de>
Date: Mon, 31 Mar 2025 12:42:07 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Abdun Nihaal <abdun.nihaal@gmail.com>, linux-wireless@vger.kernel.org,
 Kalle Valo <kvalo@kernel.org>, Michael Nemanov <michael.nemanov@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "John W. Linville" <linville@tuxdriver.com>
References: <20250330104532.44935-1-abdun.nihaal@gmail.com>
Subject: Re: [PATCH v2] wifi: wl1251: fix memory leak in wl1251_tx_work
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250330104532.44935-1-abdun.nihaal@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:3iERD4b3Yw9llUC5thBKi3u3Gag7Irv/Wl557QXFBK7/RxzamDi
 09+ph2b9U2GUznP+jeG3sqs+LuVp0mYmbZt4caAsxyMU0f9L/Uaw99ScE7PqjabGAy/eph+
 BNswROiax/V+RfxaCOQZwKfCKu8wp0UMdgveM+0UMC4HU4kbfrokPruepP5aJUJIoRv+yuM
 OundTDu8eyUaTboXioqWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UEwMep2gVxQ=;1y4Va+sjGwAqmdY3Qdw1bdlnq7v
 4N/EbXaiHSmsOuiAGLrLQkKaMdFm/dcRrRuS93pBNj9FYIXUTEoPk+3tp0Hw2wBQzhpeXQv9x
 nnlR8q/kupqJazZ8CPVdltOHO6fEXK846oyCua7qrx+zaQ+aslpkVaUxSPU7vfU9wJoz7UBsl
 Oj1rcIOH8xIcAYmrkwGLH/2tgsQe4SfUuonKDyMC7Fdxl+1BVfaEuFHyLEazbUGo/f2/TV60e
 6+nU7DuB2KmRK0xeZu/zK4sKYRj06STkZdIuOh0VyqwXxj3eFojE5siHIkFD6Kh90LsM9b73J
 3+cgRvuUjvBwC5vBfKxVQ4sBqoPKjj+sBWJEk+ib0aqINvQj3/GWyVLsRaCrjsAxRGlwwL2DL
 UPJUzQoQnJZ7rl3tFYA4kjfDp+7KV3XbRNZYCUdFBUl2sqwKjrwDYNrfLb2M8iYlFAL6pK2B9
 UncgiZzxb4k9n2SEzG4HT2+ylSPArUXgTlYR4sJiFITAxn0xbIWLtjO+u5ppCjJbS0IvAnWrl
 Bgo491kwwoJnyEBrQZQPkQqO0os0Bmacsf3Iy/e6zigFfuGXdCrBsL6GeC3NFy4rbvlRMb/gm
 t8YLHkSyJlWOy6PkGQqTTQ3rMAsMcUTkyMr1a5JMhv7nTwxWiAOp5yTvQ2MEw2F6D/pG0bhCF
 NvKpSJ+FCDUvWruzMWWC3taQdExpPD0HEYzC7sXhsAwaxY/dKz8Kf8g2krdkvbxg0d3kVWhhX
 jJ/orOpaZLbFD8ZLzz+W9MrrE4/oiVjX8WLBEZmnj5eZB8tVdBYqDF5Vqu9Sx9FHoWk1FNE6w
 n1viIEKEDd9bwqRUXOQH81z6IIdCBHwdGQg+JLQq8H1i/O2dusAL9ge6cGghTiefe4n3qLyDF
 2UiEZz1bly1oXr4ZZwD4iKX/0axzBxGwZUeqaCCAG2+Tq+E7Pbh3x56mWlgOZpOmf4+36oaFG
 MJqVgyc/dU+da2Q/0xX3yHRjF8gZUp72M0pUgSUIgD4AqQuPCzSoUU3s42k5AYd3DXf3xYNgY
 uoR/TGc66ITvB3N74YJwO9kvG2bKCZwW+xRV/NHmTR72uGrtyzEhCdYOZLP3Zjnt977bYW4uW
 CpAJyJiUm/JSQ1DjQ7S/Afir2nMDR1eeDJljq942PdJl2o3g9sGFQG4p0OVtaI1L2Q6XM1AWN
 bKkb/A1uAIRnRY9n3H0LpW8ez4cRth/LFaAy51lfFH/t0GdtGpDkqA9s5PLs8beDNL/3VuftC
 /5Qj6wFWDPqzdwP7cVwxfpwYQpLA2zHIwk0mtTt3d7kiJA87prJl7U8J/wtEeknBlCRUml6L9
 VEaI6rNtzfDkzoi69ylZjMeTS4cwJnbgwxX3tRGqdwZjqPuJM4j4rnjW0O4eILbHxhB/31xsP
 qKONIEvGvYEAlxECbelfL3BOJpL43xFEDMlIxddWZ9x8EQuVUx/s3et22BZ11AY/60FWRuY4E
 MgvDCgKBHWx5wmVYCGv05Rr32/uc6c7U8HIkiJsnwPUqTfMS5

> The skb dequeued from tx_queue is lost when wl1251_ps_elp_wakeup fails

                                                                   failed?


> with a -ETIMEDOUT error. Fix that by queueing the skb back to tx_queue.

Can an other summary phrase be more appropriate for such a software situation?

Regards,
Markus


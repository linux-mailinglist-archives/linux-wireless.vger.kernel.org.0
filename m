Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 155147BF8B
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 13:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387611AbfGaLaJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Jul 2019 07:30:09 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:43157 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387594AbfGaLaH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Jul 2019 07:30:07 -0400
Received: from mail.digitalbrains.com ([IPv6:2001:980:a370::3])
        by smtp-cloud9.xs4all.net with ESMTPA
        id smnyhu0ZsAffAsmnzhmcQS; Wed, 31 Jul 2019 13:30:04 +0200
Received: from terrence.tun.lwd.digitalbrains.com ([2001:980:a370:7000::2])
        by mail.digitalbrains.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <peter@digitalbrains.com>)
        id 1hsmny-0001uF-N3; Wed, 31 Jul 2019 13:30:02 +0200
Subject: Re: [PATCH] Revert "mac80211: set NETIF_F_LLTX when using
 intermediate tx queues"
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <20190730125412.1446-1-johannes@sipsolutions.net>
From:   Peter Lebbing <peter@digitalbrains.com>
Openpgp: id=8FA94E79AD6AB56EE38CE5CBAC46EFE6DE500B3E;
 url=http://digitalbrains.com/2012/openpgp-key-peter
Autocrypt: addr=peter@digitalbrains.com; prefer-encrypt=mutual; keydata=
 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
 ovReS4NvZuFE5d8jncr9YXuf
X-Clacks-Overhead:  GNU Terry Pratchett
Message-ID: <be1572b6-1cf6-6bd1-74cd-3b86b76b5d62@digitalbrains.com>
Date:   Wed, 31 Jul 2019 13:29:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730125412.1446-1-johannes@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: nl-NL
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIkhv2crGzCjByYh7VkKrs8/wMXq/GXrAiZT8krlal79IYok0WwDDc4XhgTcTc0QQdC+EfitD7BQ0MRi/Wmt9+YA9y4HWoJwp4WHv4LPa8io3bdNZTCy
 cNnxtgIoyqKUdt+p13bD73mkXCyLZYiycCYayvSzSBSSrTYTXDObwBn+Cy3GHjQj4XCyKMogO3ZTGU4sg0Ss9QMXCaSoxhRqfuJ9+/o+B62BJ5SQhfeyQryM
 5JJFWeELARtQgYdCC1Jcgw==
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 30/07/2019 14:54, Johannes Berg wrote:
> Revert this for now, it has been reported multiple times that it
> completely breaks connectivity on various devices.

That was quick! Thank you!

Peter.

-- 
I use the GNU Privacy Guard (GnuPG) in combination with Enigmail.
You can send me encrypted mail if you want some privacy.
My key is available at <http://digitalbrains.com/2012/openpgp-key-peter>

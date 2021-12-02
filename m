Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4F2466D4C
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Dec 2021 23:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344742AbhLBW5E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Dec 2021 17:57:04 -0500
Received: from phobos.denx.de ([85.214.62.61]:37004 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243921AbhLBW5D (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Dec 2021 17:57:03 -0500
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 66F0D837AE;
        Thu,  2 Dec 2021 23:53:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1638485619;
        bh=hXzKWymD8qubSEMxDYn9uOYmLSwlCjdx4jZciu43L4M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QhTrb1Tv+3ZtZJRZxO/pjtkm/1dzS59bmg8K8y94xxD5AfZxAATW8GfJ4JD581V8P
         J3R+rAVMTWFP9y9TK7rekS4soeK16z0tlZBzVymEC//W0t+wpneK4SX4a6IUzF0mXr
         s+SXyAUUtZ6XA5ofwMBDSsKTW77iUR2KErO/HsDDgQkHee6Gcbr/kd8ui/36Q+Q5Jr
         upQegE2njwY0b+A3tWSzNSUKf7wjlySkDuDEaDhqkVdJgxLoeEWtdKzomz6nHiKN53
         aXciCdng8vKilb8vsHEjkuzoqrgnB7jM+RJgdDEAg3UaWtLzWfKjSVWrwNmpuUsEOt
         lmK9RW5d8BrMw==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 Dec 2021 19:53:39 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong@codeaurora.org
Subject: Re: [PATCH v3] ath10k: Fix the MTU size on QCA9377 SDIO
In-Reply-To: <87sfvcl7t0.fsf@codeaurora.org>
References: <20211124131047.713756-1-festevam@denx.de>
 <87sfvcl7t0.fsf@codeaurora.org>
Message-ID: <4fdc37d43e7d728db66b97d6cbf598e2@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

On 01/12/2021 11:27, Kalle Valo wrote:

> I prefer to have also the false cases for every hardware so in the
> pending branch I added those:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=afbf52bffb36bc25e7a1e81e1f975bb75696d3c8

It looks good. Thanks for the adjustment.

Thanks,

Fabio Estevam
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-60 Fax: (+49)-8142-66989-80 Email: 
festevam@denx.de

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2322D9E44
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Dec 2020 18:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408006AbgLNRxr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Dec 2020 12:53:47 -0500
Received: from mail.w1.fi ([212.71.239.96]:59644 "EHLO
        li674-96.members.linode.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406969AbgLNRxc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Dec 2020 12:53:32 -0500
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Dec 2020 12:53:31 EST
Received: from localhost (localhost [127.0.0.1])
        by li674-96.members.linode.com (Postfix) with ESMTP id CD94E11B4A;
        Mon, 14 Dec 2020 17:45:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from li674-96.members.linode.com ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yrN_DtLEk93m; Mon, 14 Dec 2020 17:45:13 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Mon, 14 Dec 2020 19:41:49 +0200
Date:   Mon, 14 Dec 2020 19:41:49 +0200
From:   Jouni Malinen <j@w1.fi>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        ath10k@lists.infradead.org, ath9k-devel@qca.qualcomm.com,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: CVE-2020-3702: Firmware updates for ath9k and ath10k chips
Message-ID: <20201214174149.GA18899@w1.fi>
References: <20200810090126.mtu3uocpcjg5se5e@pali>
 <20200812083600.6zxdf5pfktdzggd6@pali>
 <87lfik1av8.fsf@toke.dk>
 <20200812092334.GA17878@w1.fi>
 <20201007082502.3da6rw2bkudilqaq@pali>
 <20201207140438.as2i7kwquhdxqn53@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201207140438.as2i7kwquhdxqn53@pali>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 07, 2020 at 03:04:38PM +0100, Pali Rohár wrote:
> Hello! Has somebody fixes this security issue in ath9k driver? About
> 4 months passed and if this issue is not fixed, could you please share
> at least incomplete / WIP patches? I would like to look at it and have
> this issue finally fixed.

https://patchwork.kernel.org/project/linux-wireless/list/?series=401685

-- 
Jouni Malinen                                            PGP id EFC895FA

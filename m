Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1932D48ABA7
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 11:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349333AbiAKKqW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 05:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbiAKKqW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 05:46:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F42C06173F
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 02:46:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 812756159B
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 10:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E29EC36AE3;
        Tue, 11 Jan 2022 10:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641897980;
        bh=54SBj9X+sp4MadfXt918KrrJ5rjM20hMMkJ8fEHNwWo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=CO2GH/K/g6h3y7KJ687geSgk4t6jBeIFCFfgkC2xmb45xVZdEqtxK1htzVOaSnlap
         jyRgoLrqRm3whI8TE9eF/4GECt+9oBfinUp5E0ztJwqaJtb3m92xE8gJJoUua8129G
         KOzBOg7dSU7Q7SHfaFNK2AETJHxs71xuSQtqgXlO2I9VNJybtQQyqS/QI2iSkttnf4
         0apZKWing+udXCd+JPu5uhrThAmmR0Ghwf33tvk6+w6B/ive4g+e6gn3itV1K9ujAo
         bq7Y+HAOIqGFCqN5i705RfcZOI+MefbSiJrfZLXHmMnBRU2tVyrwevv/qxpoKovcpM
         pnFUcWftJucwQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, sean.wang@mediatek.com,
        deren.wu@mediatek.com
Subject: Re: [PATCH] mt76: mt7921: do not always disable fw runtime-pm
References: <910ea351fa27e39b9116a3895090291235e24b4b.1640950454.git.lorenzo@kernel.org>
Date:   Tue, 11 Jan 2022 12:46:16 +0200
In-Reply-To: <910ea351fa27e39b9116a3895090291235e24b4b.1640950454.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Fri, 31 Dec 2021 12:36:02 +0100")
Message-ID: <87k0f6k0sn.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> After commit 'd430dffbe9dd ("mt76: mt7921: fix a possible race
> enabling/disabling runtime-pm")', runtime-pm is always disabled in the
> fw even if the user requests to enable it toggling debugfs node since
> mt7921_pm_interface_iter routine will use pm->enable to configure the fw.
> Fix the issue moving enable variable configuration before running
> mt7921_pm_interface_iter routine.

The style for referencing commits is:

After commit d430dffbe9dd ("mt76: mt7921: fix a possible race
enabling/disabling runtime-pm"), runtime-pm is always disabled in the...

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

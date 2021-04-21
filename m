Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4ED8366CDC
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 15:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242306AbhDUNaY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 09:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242084AbhDUNaW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 09:30:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE6BC06174A;
        Wed, 21 Apr 2021 06:29:49 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lZCv7-00Ekoe-FR; Wed, 21 Apr 2021 15:29:33 +0200
Message-ID: <87ecf5b648ea6d42994abbef8d9cde7e15a0a837.camel@sipsolutions.net>
Subject: Re: [PATCH 2/3] mt76: mt7915: fix a precision vs width bug in printk
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Date:   Wed, 21 Apr 2021 15:29:31 +0200
In-Reply-To: <YIAlYknkd0SoD6SY@mwanda> (sfid-20210421_152704_097013_473EB75F)
References: <YIAlYknkd0SoD6SY@mwanda> (sfid-20210421_152704_097013_473EB75F)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-04-21 at 16:15 +0300, Dan Carpenter wrote:
> Precision %.*s was intended instead of width %.*s.
> 

typo there, the second instance should say "width %*s" :-)

johannes


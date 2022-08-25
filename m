Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555BE5A0BEA
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Aug 2022 10:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbiHYIw4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Aug 2022 04:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbiHYIwz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Aug 2022 04:52:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DC8A894B
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 01:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=YH6CbTJDH/TKzNJQ6ho3kCkaU7wC/vGAng2Kc097CWs=;
        t=1661417575; x=1662627175; b=c9OcO3OlTv+hk7BjIADMMDL8oUnJqCQj5/PJ5c2SGPxhKL5
        z0rW+6K6VaMK1bKCb8YJHWynHUb3Erj6LYzCLo+QycdoOnGWLuDAP2IszTPaPF0aBTItt4vCI9HfH
        X+pz/GP9jxr7EnO7P7FLfC2JudnVmpe8eyHp0Jzl/C70jIvr6QRLZuqkmMgGeStcfzDfRMvEC/s2O
        ub1ngWYzUk9egyR1R+wC4Xd5MRkoCZmCH1HHpInlQdVQnhCknevOgVhsgX6SUBzr6nYY51lGVPaIZ
        9I36cxmRNiynJFOH2pDkAoLJQIZDbZcM8CvpkiRzlqyacHMud8k49igwU3ROKHwg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oR8ba-00GzWC-31;
        Thu, 25 Aug 2022 10:52:51 +0200
Message-ID: <f761660377bc070d060da7359b950a7936aac1b4.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: read ethtool's sta_stats from sinfo
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Date:   Thu, 25 Aug 2022 10:52:50 +0200
In-Reply-To: <ccfce8848c7bf7199ab90ccf3b4b14e1c7633385.1659060644.git.ryder.lee@mediatek.com>
References: <ccfce8848c7bf7199ab90ccf3b4b14e1c7633385.1659060644.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2022-07-29 at 10:15 +0800, Ryder Lee wrote:
> Driver may update sinfo directly through .sta_statistics, so this
> patch makes sure that ethool gets the correct statistics.
>=20

This doesn't apply, please rebase on wireless-next.

johannes

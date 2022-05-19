Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4682252D9E9
	for <lists+linux-wireless@lfdr.de>; Thu, 19 May 2022 18:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241863AbiESQLa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 May 2022 12:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241838AbiESQLU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 May 2022 12:11:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16A4443CC
        for <linux-wireless@vger.kernel.org>; Thu, 19 May 2022 09:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=17oODphRPfo7WLCPS7sil8hB+82nf7dpasD2LJbidPE=;
        t=1652976679; x=1654186279; b=qMDO3/As1AuYfPz0x3U7cD+1SYZMWpbqmrXGQ2Xc0P9QfIx
        8Czh1K7JfkGxLZAwj4doPUdQozHp19Un1xUdx6ihMYQ7XxCY0i8eajM8IsjOL4tJtPofoUFlKHYrB
        5hIQ3WoSvXTt7hBn8dXzMJLyib2NCqze76xhsMGJ9MgGNCQfHjYGN0d8oVUiPhs1rGhvEuEdn4Hex
        GTcTIYcVJhcw6RsgClPKnwrn7CUZpjM0pq40L/HfZOqu7Mo02n8X/ZurEFWTMgKGKjhfOyUfaGo2j
        UwyxH6E3N69yUb5CicNIT6XiK4AJ1HfIuUBIfjD05KQlE2w8TDE1QDANnNrjkOwQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nrikA-00GPqo-5h
        for linux-wireless@vger.kernel.org;
        Thu, 19 May 2022 18:11:18 +0200
Message-ID: <883d6430fa88efa513eae93c37c8db3d90089507.camel@sipsolutions.net>
Subject: Re: [PATCH 2/3] mac80211: refactor some key code
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Date:   Thu, 19 May 2022 18:11:17 +0200
In-Reply-To: <20220519180724.6e18b45e6d2f.I3e8b3aca8873a59da7b63e56d4349c652afc815c@changeid>
References: <20220519180724.e46f24800e6e.I2a66a9e9e350746ec891e563788d31898041ebc5@changeid>
         <20220519180724.6e18b45e6d2f.I3e8b3aca8873a59da7b63e56d4349c652afc815c@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2022-05-19 at 18:07 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> There's some pretty close code here, with the exception
> of RCU dereference vs. protected dereference. Refactor
> this to just return a pointer and then do the deref in
> the caller later.
>=20

Or maybe I shouldn't do the double pointering but rather use RCU
accessors that can do both (with rcu_dereference_check()) ...

johannes

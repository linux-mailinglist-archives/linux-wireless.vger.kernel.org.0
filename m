Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242FF77CD51
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Aug 2023 15:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbjHONZq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Aug 2023 09:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbjHONZm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Aug 2023 09:25:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909D2113
        for <linux-wireless@vger.kernel.org>; Tue, 15 Aug 2023 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=XaawGspZjz3UoHeskUzCZtbz2YnONIYVnfJ7tc4lq7o=;
        t=1692105941; x=1693315541; b=UZub9l+iWJaE2+JfuPJRSiA2abBqUMASHlLs/PEBsyuIOnF
        wj0bvxpoAhM5Svv6B/SzwuY6GYhfIL4z8XOh8Q8JojFx+MpJ5GpeWoF+kYepplMAYpwsLFtT5so1m
        Nzq0PTIp6MOoFP0MhhN4cJBxzgAp//H0mVh11xdx0xmmC4EXiIRRw2Dg9Do3jVEXymtqaQ7lC60EA
        kg0xdt7Z3ns9qpd+BF8nejUzAiJ3k5mVXI0V4Zrx/i/SqESb+/3WXjtRSbMdA8SmKeX3j8hchnlQi
        eOWbQr+E97v4oJLg3aRDQC4bYDOB0/m1mXihMx6rHEo2wzSQboRXbcJiHKw7dzlw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qVu3G-008r1w-2C;
        Tue, 15 Aug 2023 15:25:38 +0200
Message-ID: <a4edd8695f8a722c088c76496efc12069bd277ae.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2] wifi: cfg80211: fix cqm_config access race
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Max Schulze <max.schulze@online.de>, linux-wireless@vger.kernel.org
Date:   Tue, 15 Aug 2023 15:25:37 +0200
In-Reply-To: <c8b69649-ab22-a984-1767-527b73c88c7e@online.de>
References: <ac96309a-8d8d-4435-36e6-6d152eb31876@online.de>
         <20230815134247.4b4bd52ea708.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
         <c8b69649-ab22-a984-1767-527b73c88c7e@online.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-08-15 at 15:24 +0200, Max Schulze wrote:
> Thanks again. I have to back-port it to 6.1.45 manually and will do testi=
ng.
>=20

Ah, you can't port this to 6.1 series, it depends on commit a3ee4dc84c4e
("wifi: cfg80211: add a work abstraction with special semantics") which
is only in 6.5-rc...

Maybe you can cherry-pick that patch too.

johannes

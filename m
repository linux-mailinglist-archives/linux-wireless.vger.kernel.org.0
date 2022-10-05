Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730185F51FF
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 11:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJEJr4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 05:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJEJry (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 05:47:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A804A6C76E
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 02:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=cUFjCWp6HLaWaWtF+HRR9z2PKJocXE9Aa6CRRoZ/Gck=;
        t=1664963272; x=1666172872; b=VMRaCd7nmg5CIPoNrZo241heF+uApqYQ0KN8kedgvhYLBHZ
        FsyXZsmWuBrUV4AXmN+PZeola7SkxzEwL1r+w92VOCRTx3FBNXGVMJn45vE+ap9sMn8ryyzS+a7YL
        m9PL09Z2njbkeMWpizkypCGqj9kIASUMwrwPW/9+q0nZ8HQAoaNzVAQFghiS9/9h3A4JmoMkdoy1T
        qWSecylopfuZaDPt7Q9rtcCxUnwp0gf2z+lc40hhPIYUCGoB6E4wxr7ZffhK7ZUioOzKRD5R/afa6
        5nEsK9DWYNEEmuf7QYpo2LSCC8EVZb5cz/z8WTSnGYpiUkRiuQ4r/mG8anXVhW1Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og10J-00FyI1-07;
        Wed, 05 Oct 2022 11:47:51 +0200
Message-ID: <c02248328c5bd4bee1d0dbb4e6eccecb1d1a13e0.camel@sipsolutions.net>
Subject: Re: [PATCH] iw: info: print PMSR capabilities
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jaewan Kim <jaewan@google.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 05 Oct 2022 11:47:50 +0200
In-Reply-To: <20220923015550.1292547-1-jaewan@google.com>
References: <20220923015550.1292547-1-jaewan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2022-09-23 at 10:55 +0900, Jaewan Kim wrote:
>=20
> +#define PRINT_FTM_U8(T, NAME) \
> +	do { \
> +		if (T[NL80211_PMSR_FTM_CAPA_ATTR_##NAME]) \
> +			printf("\t\t\t" #NAME "=3D\n", \
> +				nla_get_u8(T[NL80211_PMSR_FTM_CAPA_ATTR_##NAME])); \

This doesn't compile, and there are also a few compiler warnings.

That's all easy to fix, but it does make me wonder if you tested this at
all, or accidentally sent out an unfixed version from before testing, or
so?

johannes


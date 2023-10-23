Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8617D3A06
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 16:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjJWOqv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 10:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbjJWOqV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 10:46:21 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFA9212B
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 07:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=xMh1Rk1F4xYVkl1iWVyhzEnYF/vO6qhBUB1Odxd3/n4=;
        t=1698072359; x=1699281959; b=i1vpCcgpMGE2IlDjkMfx1DJKwAAtNu0vqtv6i7bFPY68ZG8
        HnvP5Nhad2ROGrRi2iKwv93X0pXFw33cLeWlJD4Nk0YoCyCCrwvdwAG23zWPQHfsWbTAZhJX7E8iB
        uid2mEr4wWoy1VZKzV8bQ1f3+NwDrw/kF9wyTbUCb52tFl4Qu98s5r2e/Qa0BPqA2RWLL8PeEaaHs
        mSCR/tgcQ222X94fwTVo107YF36TKcr3JbZCZl62WeMmTogUiWkc9VGh6MqN/tl1gW4mv6Zg85Nte
        xDyM7Q1IEyq5+4jRF+z9slbamwxkpihbQY7MLIL6Zj6nl3U17SnSHxqPMFwyOyYg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1quwBm-00000000JSi-2zr6;
        Mon, 23 Oct 2023 16:45:55 +0200
Message-ID: <011c648db5718754bd3f712a38e79235e3f8e836.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: iwlwifi: use kstrtoX_from_user() in debugfs
 handlers
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dmitry Antipov <dmantipov@yandex.ru>,
        Gregory Greenman <gregory.greenman@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Date:   Mon, 23 Oct 2023 16:45:53 +0200
In-Reply-To: <20231023143459.157306-1-dmantipov@yandex.ru>
References: <20231023143459.157306-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-10-23 at 17:34 +0300, Dmitry Antipov wrote:
> Use 'kstrtobool_from_user()', 'kstrtouint_from_user()' and
> 'kstrtoint_from_user()' in debugfs write handlers, adjust
> style, add comments where appropriate. Compile tested only.
>=20

Did you do that with spatch? :)

We probably have a lot more files in other places and not yet
upstreamed, so it'd be useful to have that to apply it elsewhere?

johannes

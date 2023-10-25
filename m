Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23197D71A6
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 18:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjJYQXm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 12:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYQXl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 12:23:41 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD1E92;
        Wed, 25 Oct 2023 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=KSvipvPwB0LwmbdUXHWvqGMVCXXCLb37wMlJPclW53k=;
        t=1698251019; x=1699460619; b=teTI4x/RdRNj1XiUEd25aW1RIcUoHx418GuysskiItD3RZ5
        TsRVIjgYFv3WYomVJegyhPHhRVtPrBYLTr8kgl8jQIgDgJr9bbvYsKyb8q5ZYeEHdigM7FTpXarRY
        QIZDp4GdJ4giL1tLll+tgQgXN01f7huDPekf626E+d1/J6xiS5uS18Ty/t7L5n9UGkPQse0LikIsZ
        C9Sms5kWzaPlxD53da6RArx0+A62BtSjQidIjPafeH2suL99j7t84qtHGFIIkECScBbLDTDUK876i
        5UsUi9p0uWl4QJX/ZqQoB7h1Yxj3i1tLA6p59515gxOx5h8szSoHreVN3tXVleQg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qvgfL-00000002ccP-3vTk;
        Wed, 25 Oct 2023 18:23:32 +0200
Message-ID: <b96201ae56ab165701fd5057bb9c52bb84369d91.camel@sipsolutions.net>
Subject: Re: [PATCH net-next] netlink: make range pointers in policies const
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
        j.vosburgh@gmail.com, andy@greyhouse.net, dsahern@kernel.org,
        jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        vinicius.gomes@intel.com, razor@blackwall.org, idosch@nvidia.com,
        linux-wireless@vger.kernel.org
Date:   Wed, 25 Oct 2023 18:23:30 +0200
In-Reply-To: <20231025162204.132528-1-kuba@kernel.org>
References: <20231025162204.132528-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Wed, 2023-10-25 at 09:22 -0700, Jakub Kicinski wrote:
> struct nla_policy is usually constant itself, but unless
> we make the ranges inside constant we won't be able to
> make range structs const. The ranges are not modified
> by the core.

Makes sense, wonder why I didn't do that from the beginning ...

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes

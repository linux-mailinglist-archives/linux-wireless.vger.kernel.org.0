Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F206FDCB7
	for <lists+linux-wireless@lfdr.de>; Wed, 10 May 2023 13:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbjEJL0a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 May 2023 07:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbjEJL0Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 May 2023 07:26:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D9A7D9E
        for <linux-wireless@vger.kernel.org>; Wed, 10 May 2023 04:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=qKTN3bkuHHaB9/MlmakcV7+e37PbUREzYlO6cAfSfc0=;
        t=1683717962; x=1684927562; b=TkP5tRn+8riZudlsD48YAhSL6r/XDbsPuAMyBT+WpzhqBQs
        LYwLUQKl7hkdNm9IiF0fBtvZtF2K6dDxXt10T9ca4mAo180A60K6HIV6f8mafST2EK1vnTTwHgDo/
        bnfOKD6hRvXn8p2bqsPXVrE3WDAa5wO58Rbtotw2U6bx9EycPkMJTbDprCGrtSgvvgmhxfTsGCHfx
        TBrirwPuYqvbxG/Pfk8i7hzzU4LxdN3WKIPqe8OUA/srkbcrbIR4UDJOS0i+wj65D4ELBb1fAj9n1
        B2GoAIt+m1qNVR92lcg3VoCHbc0gRBfifRaMxLcL437U+IJwcA0Rh2uCrqgIISVA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pwhxA-005N5u-28;
        Wed, 10 May 2023 13:25:52 +0200
Message-ID: <ab3ddf836d89af4c559543c9d519f8dab394d684.camel@sipsolutions.net>
Subject: Re: wireless locking simplifications
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Benjamin Berg <benjamin@sipsolutions.net>
Date:   Wed, 10 May 2023 13:25:51 +0200
In-Reply-To: <f3471853cd7063a4bd2d783caa14706ee9115748.camel@sipsolutions.net>
References: <f3471853cd7063a4bd2d783caa14706ee9115748.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
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

On Fri, 2023-05-05 at 23:05 +0200, Johannes Berg wrote:
>=20
> +	/* FIXME: can this be done better? */			\
> +	WARN_ON_ONCE(strncmp(current->comm, "kworker/", 8));	\

Ah, also, is there a better way to do this? Not strictly needed, but
some kind of debug check that you're calling the right thing would be
nice.

(Unless we do the user mutex to workqueue thing :) )

johannes

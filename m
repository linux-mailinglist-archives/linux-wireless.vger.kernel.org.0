Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D864F666F1D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jan 2023 11:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjALKLC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Jan 2023 05:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbjALKKR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Jan 2023 05:10:17 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F0F5FAF
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jan 2023 02:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=u+oY6ojn7ydLsUq1H5+DotJlHOoi3l+eh7PpzRbscUk=;
        t=1673517926; x=1674727526; b=IJi5LE1Y6wkorRY3vEXedDKLUw2UlXnmsMIDaTVzg6c/Dty
        O7igRXjynUmFnA+gIyAGd+QbJeURpydK5Yj97OoiXokOYZEC9RnMrKVJzAqnYHuRJfp5PK6fru5+B
        V3QRYBX4EUHLzYl5EJ3aClG6wv3zyGL7X44XdOeKoIfGoIi9spWhJenfuFhnadl7tgtfOJMwNnQSX
        veQWfg0TYvS00QBWvVzFzsX//5SteJs6Jhcw17jfoiEdOe+oG+0oC5KehsFrgSN/NpJIhJj+2dGTL
        zsOHbriU3B0V8Om6a2qZgIgNhzGW8kgX5q3tdZKEztYuxSYrRMb6mTK1L2wtT/kg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pFuSa-00H2aO-1V;
        Thu, 12 Jan 2023 11:05:24 +0100
Message-ID: <9d6ec2ca03f6625809ccca6006f2ce842f9fe20a.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/1] iw: add support for retrieving keys
From:   Johannes Berg <johannes@sipsolutions.net>
To:     =?ISO-8859-1?Q?Rapha=EBl_M=E9lotte?= <raphael.melotte@mind.be>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 12 Jan 2023 11:05:23 +0100
In-Reply-To: <20230102111213.77129-1-raphael.melotte@mind.be>
References: <20220822074318.291949-2-raphael.melotte@mind.be>
         <20230102111213.77129-1-raphael.melotte@mind.be>
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

On Mon, 2023-01-02 at 12:12 +0100, Rapha=C3=ABl M=C3=A9lotte wrote:
>=20
> +	/* key index */
> +	if (argc) {
> +		nla_put_u8(msg, NL80211_ATTR_KEY_IDX, strtoul(argv[0], &end, 10));

This is odd now - if you have &end you should check that strtoul()
actually consumed all the input etc.? Otherwise might as well just use
atoi(), but I'd prefer with the checks.

> +		argv++;
> +		argc--;
> +	}
> +
> +	/* mac */
> +	if (argc) {
> +		if (mac_addr_a2n(mac, argv[0]) =3D=3D 0) {
> +			NLA_PUT(msg, NL80211_ATTR_MAC, 6, mac);
> +			argv++;
> +			argc--;
> +			nla_put_u32(msg, NL80211_ATTR_KEY_TYPE, NL80211_KEYTYPE_PAIRWISE);

maybe add that before the argv/argc (and maybe break line in there) -
first I got concerned if argv/argc was used in that nla_put_u32().

johannes

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1E062D862
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Nov 2022 11:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbiKQKtu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Nov 2022 05:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbiKQKts (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Nov 2022 05:49:48 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5E813F61
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 02:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=kJVLtW1AzLtyYblvIpcHD/wIyuCRdlqsxPy7DG308nA=;
        t=1668682187; x=1669891787; b=yOiChw+tYrz09q1YlUSMjRFD1rvpp0sk+ILDGgjWy/DmQlr
        kBykh4ktlESghSP1BosLxmZ/Dbq5cHlpnmu/CI3SOoNIlEh2OmMoqE5AusepSOaN9wF+3v1HW82SY
        KI6Apj/4lsJevShxnECtrmFthY0tObkdPjYF8pXTHtFRAtaBkpVFJUaH5S/4OZhFSPt1d+GSfybs0
        uFP4VjXzvjXx6MelL6GC9x6IaPDuqBkaog4rp0f2HWvmXxGQkkBc83ycdevlYMEUrSei+NuzGsFyJ
        GB3gS6TnKbZVlt7PbspsYihYzZ+z9V9Mt124aqAOi4vd9fQU4kndPj0b4uiHDoKA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ovcSm-002CAT-2T;
        Thu, 17 Nov 2022 11:49:44 +0100
Message-ID: <afcfe09bd2ef5945419dbb2b9e3f791d297ac5ea.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 1/2] wifi: wireless: warn on most wireless extension
 usage
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 17 Nov 2022 11:49:43 +0100
In-Reply-To: <87v8ndrh53.fsf@kernel.org>
References: <20221104174218.26f9541c0bfa.Ifcf30eeeb8fc7019e4dcf2782b04515254d165e1@changeid>
         <87v8ndrh53.fsf@kernel.org>
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

On Thu, 2022-11-17 at 12:48 +0200, Kalle Valo wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
>=20
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > With MLO/EHT support around the corner, we're going to
> > remove support for wireless extensions with new devices
> > since MLO cannot be properly indicated using them.
> >=20
> > Add a warning to indicate which processes are still
> > using wireless extensions, if being used with modern
> > (i.e. cfg80211) drivers.
>=20
> I doubt people outside of wireless know what MLO or EHT are :) Also it
> would be good to mention what's the replacement for wireless extensions
> so better to spell out that as well. So maybe use more widely known
> terminology like this:
>=20
> "With Wi-Fi 7 (IEEE 802.11be) support around the corner, we're going to
> remove support for wireless extensions with new devices since Multi-Link
> Operation (MLO) feature cannot be properly indicated using them.
>=20
> Add a warning to indicate which processes are still using the ancient
> wireless extensions, if being used with modern (i.e. cfg80211) drivers.
> All those users should be using nl80211 instead.
>=20
> Ancient drivers, which are not using cfg80211, are unaffected."

Sure, makes sense I guess. This might become a more referenced commit
perhaps :-)

> > +#ifdef CONFIG_CFG80211_WEXT
> > +static void wireless_warn_cfg80211_wext(void)
> > +{
> > +	char name[sizeof(current->comm)];
> > =20
> > +	pr_warn_ratelimited("warning: `%s' uses wireless extensions that are =
deprecated for modern drivers\n",
> > +			    get_task_comm(name, current));
> > +}
> > +#endif
>=20
> Maybe add ", switch to nl80211" also to the warning message?
>=20
It already got so long ... but I guess that makes sense.

johannes


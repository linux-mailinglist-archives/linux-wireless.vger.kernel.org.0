Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F7E7B2C93
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Sep 2023 08:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjI2Gsb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Sep 2023 02:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjI2Gsa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Sep 2023 02:48:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297391A4
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 23:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=qKjeAecmuz2bAiUWd004K4gJSct95dOnTYQGx96vz2w=;
        t=1695970108; x=1697179708; b=iQ8O7/BYcCLmXe7DgDLWVDiRzrhDoIN6l3GNnxl792wNdn+
        wFZA3hVttDNGHZM0SLBdtNZkjJbsBvgwQ6qQEB0M/XHSOstYq+wMRtfvU8llxia9WLtYVMwcfMpL/
        JfdDgAp9WQ8dt5C8mLJr6u4jRqBunARGqm/m4iUeHFGJF6316PbJjodGM1/Qp7YNxpUL8UYmBtWEj
        BPsMnh5ZRDIE6xZMp9Jbdoq9HRaIItZfdgwYK2cuRiR6qM3GK2HsV2NMHx1c0J/p7zPccELJSGDzO
        KNQ2+q6MKAIDSawrdX20KEuCB65Y7KkvnK9C0hvCNjSAnYVfrA2ALMTVTIEcaZiA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qm7IW-00BKda-1J;
        Fri, 29 Sep 2023 08:48:24 +0200
Message-ID: <3ff89e5a9ee6aeddaa771e1ada0faf13ce549f9f.camel@sipsolutions.net>
Subject: Re: [PATCH 08/18] wifi: mac80211: mesh: fix some kdoc warnings
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        gregory.greenman@intel.com
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>
Date:   Fri, 29 Sep 2023 08:48:23 +0200
In-Reply-To: <ae8e358d-3d02-4167-9232-5da8a2ec3d1c@quicinc.com>
References: <20230928143539.1037500-1-gregory.greenman@intel.com>
         <20230928172905.33fea2968c62.I41d197b570370ab7cad1405518512fdd36e08717@changeid>
         <ae8e358d-3d02-4167-9232-5da8a2ec3d1c@quicinc.com>
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

Hi,

> > +++ b/net/mac80211/mesh.c
> > @@ -56,6 +56,8 @@ static void ieee80211_mesh_housekeeping_timer(struct =
timer_list *t)
> >    *
> >    * This function checks if the mesh configuration of a mesh point mat=
ches the
> >    * local mesh configuration, i.e. if both nodes belong to the same me=
sh network.
> > + *
> > + * Returns: %true if both nodes belong to the same mesh
>=20
> I thought kdoc used Return: not Returns:
>=20
> <https://static.lwn.net/kerneldoc/doc-guide/kernel-doc.html#function-docu=
mentation>

Huh, indeed.

I'm sure this actually fixed it though because we did start running
kernel-doc on this code internally (via W=3D1), the issue at hand was that
we used to compile without mesh (not supported by iwlwifi) and now added
it for hwsim testing.

So ... I looked, and indeed _both_ are accepted:

scripts/kernel-doc:

        } elsif ($newsection =3D~ m/^returns?$/i) {
            $newsection =3D $section_return;
        } elsif ($newsection =3D~ m/^\@return$/) {
            # special: @return is a section, not a param description
            $newsection =3D $section_return;


which I guess means

 /**
  * foo - ...
  *
  * Returns: bar
  */

and

 /**
  * foo - ...
  *
  * Return: bar
  */

and

 /**
  * foo - ...
  *
  * @return
  * bar
  */

are all accepted.


Though "Return:" is more common, perhaps due to the docs:

$ git grep ' \* Returns:' -- | wc -l
3066
$ git grep ' \* Return:' -- | wc -l
9189


Personally, I find "Returns: %true if both nodes ..." to be nicer to
read, since it's more like a sentence?

But then again it depends on whether you're reading it as a description
or an instruction, I guess. "Returns: something" is a description, and
"Return: something" is an instruction (for the function). Hmm.

I'm inclined to say I like the descriptive text better, but since it
shows up in the generated documentation with "Return" anyway, maybe it's
better to have it in the same way in the code?

Though of course it's (slightly) easier to just apply it as is :)

What do you (and others!) think? Does it matter?

johannes

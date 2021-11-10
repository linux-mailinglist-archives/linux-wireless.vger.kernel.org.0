Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF0644CCEF
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Nov 2021 23:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhKJWja (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Nov 2021 17:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbhKJWj3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Nov 2021 17:39:29 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F352C061766
        for <linux-wireless@vger.kernel.org>; Wed, 10 Nov 2021 14:36:41 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id br15so5768972lfb.9
        for <linux-wireless@vger.kernel.org>; Wed, 10 Nov 2021 14:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=67v8CYjUoqWXmr8UJo7fttpj4RphDD0fJcr4jA9b+dQ=;
        b=jcMAZ5Dbl1y1hcNIFt/RfcTVbNYE46rtD/TmjyB50zYYyy36I4ahKH8AXLC3sMrPuU
         jg/pwtzCeosMhHxppFObleLcygAf5yRZhRIj1b/eF1KUbd7L+l+iGUWKLgHUh4DJfSC2
         IOppu7PjonS35UU3b6bwHAvl+/hyJqsNAlETljLt3+6ANgJhyovfS/KauHdiYY2qpX5h
         JBBRD9ksMK7P/NVYLQdeLiohfJh1Yq8O8Cr+8tCpwPgq/YKIMEjmLvjhmVNYCZRzXMhx
         adkbV/Yf8iv6GLBPiBJSY90X4jcIUJvO6E6xJO/GocQmwrvm+g0RDLmoY511aXRjEKM9
         JRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=67v8CYjUoqWXmr8UJo7fttpj4RphDD0fJcr4jA9b+dQ=;
        b=V7D/J2+Tt4T0YE3JI/d1VeMunuKO8nQf/b6Wts2zJZP4Dr15HGGL6A6mOzMyjqX6x/
         v0YrmTB6q5yy9uhOrKXImMC2w/KwXWK90cj13assHaDJqsHdAWB1UycUu3Z3zL9TztYB
         LUBaZskNvEpDrioqtUkE5Vu0kuyKJGLwShAmbdi7OW/AIZdIyu8ojQuVXGFSGhZMgrqc
         gPiVhIlD12x86qgA7dAcQS47wpwk+ZK8MRTSNaoLcsuXjQVeqJdFfpnCapPR73mjQI3F
         MtT7r05QTp6nqrpge2IiReJ/0xZJREb4iak1TOc2CRk8uj/HUcaS1+3enEC0qdqH5XPV
         s89Q==
X-Gm-Message-State: AOAM533di8T+TdRV7Tu4UIKffVDpyZKm0sF3v/GJtG+FRZEI6+ZmPmF+
        mPhPsHRwza7oZJBkjaOHIlFVMb3DMq2PKSUUmEQ=
X-Google-Smtp-Source: ABdhPJwEnYgc6umu7stiqISVDMGNeGTafcOa4T4zJUhJ+27MqJJ4PpApJp6psbYqpKhfJUEZWKmaVrNR4tY3aOKVWfc=
X-Received: by 2002:a05:6512:239c:: with SMTP id c28mr2441783lfv.502.1636583799837;
 Wed, 10 Nov 2021 14:36:39 -0800 (PST)
MIME-Version: 1.0
References: <20210820203531.20706-1-greearb@candelatech.com>
 <20210820203531.20706-2-greearb@candelatech.com> <950c52e2-8422-36f0-9024-55e45ef2672c@candelatech.com>
In-Reply-To: <950c52e2-8422-36f0-9024-55e45ef2672c@candelatech.com>
From:   Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date:   Wed, 10 Nov 2021 23:36:28 +0100
Message-ID: <CAFED-jksc5480ZfX+RK+c1FUs43kRvnDJv+xA8BfFE7YN5i86Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mt76: mt7915: fix radar detector logic
To:     Ben Greear <greearb@candelatech.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

=C5=9Br., 10 lis 2021 o 21:36 Ben Greear <greearb@candelatech.com> napisa=
=C5=82(a):
>
> On 8/20/21 1:35 PM, greearb@candelatech.com wrote:
> > From: Ben Greear <greearb@candelatech.com>
> >
> > Before this patch, if AP went from ch 100 to ch 36, the radar detector
> > logic in the firmware was not being disabled.  This made the AP appear
> > to be up, but no beacons were seen on air until module reload or
> > reboot.
> >
> > To reproduce this, I change hostapd.conf and restart hostapd.  Others
> > on openwrt used their UI to make changes and problem was seen, but
> > stil others changed channels in some other way and/or had some other
> > difference and could *not* reproduce it.  So, something perhaps a
> > bit subtle.
> >
> > To fix the problem, stop depending on comparing dfs_state, store last
> > freq/bandwidth to detect changes in that, and streamline code that
> > checks to enable/disable radar detection.  And add in error checking
> > and dev_dbg logic so one can see what is actually happening if need
> > to debug this again.
>
> Back when I was working on this, someone sent me an email or chat or some=
thing
> about some other way to do this that was simpler and just relied on
> mac80211 timers.  But, I cannot find that email for the life of me.
>
> In case you are reading, please resend!  Evidently this 2/2 patch had
> some regression for someone so it is not acceptable upstream in
> current state...maybe the mac80211 option is best.
>
> Thanks,

--- a/mt7615/mac.c
+++ b/mt7615/mac.c
@@ -2034,6 +2034,11 @@ static int mt7615_dfs_start_radar_detect
  phy->rdd_state |=3D BIT(1);
  }

+   /* end CAC - upper layer will care about it, lock tx, beacon setup */
+   err =3D mt7615_mcu_rdd_cmd(dev, RDD_CAC_END, ext_phy, MT_RX_SEL0, 0);
+   if (err < 0)
+       return err;
+
  return 0;
 }

@@ -2104,11 +2109,7 @@ int mt7615_dfs_init_radar_detector(struc
  phy->dfs_state =3D chandef->chan->dfs_state;

  if (chandef->chan->flags & IEEE80211_CHAN_RADAR) {
-   if (chandef->chan->dfs_state !=3D NL80211_DFS_AVAILABLE)
-     return mt7615_dfs_start_radar_detector(phy);
-
-   return mt7615_mcu_rdd_cmd(dev, RDD_CAC_END, ext_phy,
-   MT_RX_SEL0, 0);
+   return mt7615_dfs_start_radar_detector(phy);
  }

--=20
Janusz Dziedzic

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E053EDAE5
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Aug 2021 18:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhHPQ1f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Aug 2021 12:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhHPQ1e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Aug 2021 12:27:34 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28E1C061764
        for <linux-wireless@vger.kernel.org>; Mon, 16 Aug 2021 09:27:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gt38so11670828ejc.13
        for <linux-wireless@vger.kernel.org>; Mon, 16 Aug 2021 09:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sk+JVEEJI+Xw4iz7i2lbGGFasWfOxVF0w31sBt6vjGQ=;
        b=CRG4EC3a9HSKXXcNRJJCAEyiOH8JEXmncIDP0gOzjAoYJv7TshvtzZ/9vVHHggu7g1
         7zssP6rHXEj2n8Y92AWmLXSX7wmyEUuW69YwxMLlr2YmO3oGXgxoX++WDVYLTysla37B
         564euKvrPFRcVCX+0BDflBNYijJzF3NgJ0LHH90DH7Npzc6Sm1wUxWrfbBI7czy5WWMQ
         faSAiolVcJR2BDsXlZsbIruNsP0UHBdxp32a7SvQR6eCYV6lSBxqhaPObLffar9/l+Hz
         E1z1Ax86uEFgTZBl7iSToC7Tdk0lMoPaexpwXXklk9bt3peAB7M73DTGk9XhtCWxr4Pj
         kGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sk+JVEEJI+Xw4iz7i2lbGGFasWfOxVF0w31sBt6vjGQ=;
        b=gweM65R+0X1T5s+/jnha4NjBAFMrihye+rgfRpzXGyEoPIsBOZ+Bdj0H+vaNPv4Ess
         yl0H+yXaCtZL+L6oPmK/r3dczqphfPeIa+3gxsWFStDq/ye5HMQZTV4IHF2nm2o8qDcl
         4+CcQ8iSc81dQQLg6P/EvTlCxfXUp53gYy4MXgkbBQQ+AhIK0A+6ZVhnwG6M8VNfHlrd
         TrvbpRjV9MFTMCY4KBgEyZ5fIhNmRoeTJil0RXU/3aflaUeoJOeFLdCk5WGBdXd4y8lv
         mrgi31Yq/hxi7qSCSu5HJ7tyPZomuTxlqS4DDa3LqrfV4BeGaT4KhpGqRabsMUGPYh+F
         H5gg==
X-Gm-Message-State: AOAM531ZbYckOMqobxXqhtn+oL5B0zPl2I8bKgRn9KHPt4Lt67FzA4VA
        08PrctOe3DQFn9pi+6qaiaZrOoe5aM4JS8wHUnI=
X-Google-Smtp-Source: ABdhPJxZNyBmUiJP4qwpyqAeeHQYC9j1zQAOu2toPe6cUsTjciDa1/tarj0E/0zX4hLEPfbHOE9ZsQrpsdT8yBGaqYA=
X-Received: by 2002:a17:906:c315:: with SMTP id s21mr16603498ejz.362.1629131221473;
 Mon, 16 Aug 2021 09:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAAZjYunwQ5UtjJuvrBNWU9qTf72WMRjoaYD+mgn7OaqmXXZ+fw@mail.gmail.com>
 <aa62f2ff1ae79089d63f25c3b215f7ed7196ae15.camel@sipsolutions.net>
 <CAAZjYumZQJud7y0nVXhO5RLCrx=MF3hLEv9T7U0bAWw=63WoKw@mail.gmail.com> <dd83ba70fd669b6bd5825b745e07ab331ba7184f.camel@sipsolutions.net>
In-Reply-To: <dd83ba70fd669b6bd5825b745e07ab331ba7184f.camel@sipsolutions.net>
From:   Milo Garcia <ing.eagm@gmail.com>
Date:   Mon, 16 Aug 2021 18:26:49 +0200
Message-ID: <CAAZjYukkV0iZ=94CtpqfhAiYUV4uK=HtKW9uMLyJi12ODWbtjA@mail.gmail.com>
Subject: Re: iwlwifi: OFMDA Sniffer not capturing actual data
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> oh, but that's not the *data*, that's the RU allocation information.
>
> Looks like we don't report that for 0-length PSDU, not sure, probably
> the DSP doesn't propagate it if there was nothing for the AID you
> configured, or so.
ok, so if that is the allocation and we are getting 0-length PSDU,
then it means that I am sniffing with the wrong AID?

In practice then I will just need to select an AID to which data is
being sent and then I will be able to see the HE_MU Data?

My goal is to see DL OFDMA data in wireshark. Thank a lot for your help :D

El lun, 16 ago 2021 a las 18:10, Johannes Berg
(<johannes@sipsolutions.net>) escribi=C3=B3:
>
> On Mon, 2021-08-16 at 18:04 +0200, Milo Garcia wrote:
> > > What exactly are you seeing?
> > https://imgur.com/N7DdDS3
> >
> > I was expecting to see the data in the RU but Wireshark only shows
> > packet length of 86 bytes
>
> oh, but that's not the *data*, that's the RU allocation information.
>
> Looks like we don't report that for 0-length PSDU, not sure, probably
> the DSP doesn't propagate it if there was nothing for the AID you
> configured, or so.
>
> johannes
>

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD816B70BC
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 09:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCMIAT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 04:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjCMH7h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 03:59:37 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0A857D36
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 00:57:01 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id y3so231361vsl.11
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 00:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678694216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sysjgo1iroCq1PGPMcxHYcJ58uKAcoIBYkmm2Rx4bGI=;
        b=KXhC1FXwnQwj0EnHEzCNw1VYze6E0LuW8PPX6sopnLlckYDSosuKzcY8pr5ECtZQ2O
         UbqKVnxWY+GAl/HmTUClofet7Jr3db4XpG4V6K0K4mEzFsonLNrNis3yEsyjD3WlVymx
         x3SIZwD2oKJm1+eHGkya5Y+xscxc4AsgWpBIVoYKMBpaZSPUTITSVUaUXRbkajVbCYhC
         k0s3pFz+t5UQnF6KN7MYJfYrcmSI9hXIeapA4m/LldlDR54UAM1mNZYDzSMiBAZ3+O3Y
         WcTn4adlUaE9eq14qNRNg2JohCMyGDQ5ok1feQhldl9PZxwzeXZUI0QzbN8EdePuKpL3
         CynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678694216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sysjgo1iroCq1PGPMcxHYcJ58uKAcoIBYkmm2Rx4bGI=;
        b=Uff75noWgKGbo65rpaY2W2+XwVdEgZwO5YnHYAFHXvRbsA1SF0PiAUVUxnVXOAOzza
         mtdQarRnjiyfn8L5n2fBcpFDHXNQWamhMamcqaE4v0kR7cpWwgrQK+BixNqxeQZh2ANk
         hsKdZrhuNfy8rDsTzJ0PfQjCzA0hCQz7btjbyY1NFDGfniTNVcJt6+S9vKn4jIYSrxTx
         u/OGL9XxlyO2JF3wCjIrFkwc8JhgltxzQz6B2qAqu18san4036alMdUZJ442bZHhB47r
         Lc/A1b57mts33s2jmqxKAAebSxLdP4IYT+CUT4nemLjzk8aAI81Ghg7b5NAL+SYCwcjT
         kueg==
X-Gm-Message-State: AO0yUKVpNPGTsHdm1ydcd/F0Wg2zIXZDgjaBDVmpu8ozF8MbVGN9JGG8
        Xnf7IZLcTpneczPJsP3vetg5KI71IjyXJo/uYgMtIw==
X-Google-Smtp-Source: AK7set8CBieS6yjL4waHMsMpatn9duc3lZELrYwe4073Ne76dis4CR3fyYId9ouuyZvVVwgFMhknjo1N1mEz6NVHpsw=
X-Received: by 2002:a67:7305:0:b0:411:c666:583b with SMTP id
 o5-20020a677305000000b00411c666583bmr21778072vsc.5.1678694216402; Mon, 13 Mar
 2023 00:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230302160310.923349-1-jaewan@google.com> <ZADgBqP57XcW3/tH@kroah.com>
 <87cz5mz04t.fsf@kernel.org> <CABZjns4xYjcn4CQzEoiozz9j7mKF0py0WE+AZ2Koi9Vz3khVLQ@mail.gmail.com>
 <87lek7pnh8.fsf@kernel.org>
In-Reply-To: <87lek7pnh8.fsf@kernel.org>
From:   Jaewan Kim <jaewan@google.com>
Date:   Mon, 13 Mar 2023 16:56:45 +0900
Message-ID: <CABZjns52wcHwofKqkh1Q2wM7VfgU93z7e94K04akeHHm1v82iw@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] mac80211_hwsim: Add PMSR support
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@android.com, adelva@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 8, 2023 at 7:05=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote:
>
> Jaewan Kim <jaewan@google.com> writes:
>
> > Sorry about the inconvenience.
> > I checked all patchset comments and also got internal reviews,
> > but forgot to double check in the cover letter.
> >
> > Should I send another patchset just for cover-letter?
> > Otherwise let me keep this as of now, unless I need to send another pat=
chset.
>
> Please don't use HTML, our lists drop all HTML mail.
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

Sorry about any inconvenience caused by my mistake.
Uploaded a new patchset without 'CL', and also double checked 'plain
text mode' before replying.

--=20
Jaewan Kim (=EA=B9=80=EC=9E=AC=EC=99=84) | Software Engineer in Google Kore=
a |
jaewan@google.com | +82-10-2781-5078

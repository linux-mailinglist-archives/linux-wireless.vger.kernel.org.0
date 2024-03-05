Return-Path: <linux-wireless+bounces-4377-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1A8871DE6
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 12:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2945A1F2B3FF
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 11:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980665A114;
	Tue,  5 Mar 2024 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAYst8qx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF965A4CA
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638341; cv=none; b=QVBil5K0Bv3/EVSBuYKQb9DEiekGQiDPk3nUoIEf2HMfV6f8UM7kTVfytQHK1rvLfJOKcTW2igyHgl2u8G56SzK2JkxiXutVE6Zv6SMrLKCFi88butmLs9+OhFnEWzlg0bLeHrQhRWfCk/wdmzD9kHFki6cTP2darn0fsWy5bgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638341; c=relaxed/simple;
	bh=k+Vpfre8OOHrp6Ki7lPbdsUd3dzSm5Dn9i8Y5JhELd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9H/0RJWoboRTGOhmYK1JdX+eobFZEzpBrIN2dqB3+xL3NTgPFY+xSeJQOjE4d8fKU9zbAVDZWd8Wca+uybO2CnOiMeUj4c8cRJkgzpzmEAjzdkADE4O/yT/8IkuRkv8G4FWRr9nCM1L9++i1o1kSAughFYpdCoiGb1kDuz8Hbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAYst8qx; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso4481898276.0
        for <linux-wireless@vger.kernel.org>; Tue, 05 Mar 2024 03:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709638339; x=1710243139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=twlQ/hLjmxNBF9eMFAk2VQFxlFQHT0OoHPlJuY8/dQw=;
        b=gAYst8qx0AXeKUBrAq/RJfmGd7HcxjPr2XeT+wUkrYNNT4MgBd+6O+oKshRD7ibc8N
         45rbFodebb9ETxPkuBeiaBQiqCS7/wec3fDlW/JslW80AAjLMdemgmajuGOqrRJFYkl0
         5gzAC1iPjQd8Hk7wYlMyde98YuYpMl88qtwAFj/ukWsnidb+xgmo2DfOrtrzDeVJrVZb
         OzKLEHuA2n37P77OESsOY7nQUXcLqQBYA5QjMSfyDotggwi+csiXJqFIAHcq1onU9ZZc
         jcM14u9KDSRXKlx6xpgE18QAuwVf7C7r0o19NCiPJYOoJxqa9+/wNT54TogjmfAUIlr+
         YSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709638339; x=1710243139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twlQ/hLjmxNBF9eMFAk2VQFxlFQHT0OoHPlJuY8/dQw=;
        b=aG2ciKidYTcX05A90FqQjUKW3xfP4WSlbYKSDoV8Z6M7zh4Yc55FynOaRzmnNTZim+
         CW41fy1dqJ+uy/iNYQ9pDOvgcRk9fFI3BBJ0+mrCtx87K7ttpZJeFSopvGcLsFc+Wleq
         buLhQB7XAnBR3gJuEeQij3XoMXinagTsSQNzMCo6yQSm1+WXpFr+FcZEmLWVh1HJwzbx
         OljZH/859Idb3Pxl5kYA1y2oxpLiRbrS/I02WPzG1Plrc+RkJ0iaEbp7kLNRGAd4kQqo
         CAKocgcwRQXOeM13HHEFNzFyDacA+3KtTIAgBz/pAvDhBWVRgMZ8/OlY8Z9C1PQ45TNd
         a6jg==
X-Forwarded-Encrypted: i=1; AJvYcCVS1DiSMBWRq/cw/Gw/8TnQvXtm3yUx8DHrsuJRe9/I0li6QQ5UEYi7JOf0XECG4t6OF8fdyp65foMmhoKO7tJNzO/k70FtgEO45NNP/LI=
X-Gm-Message-State: AOJu0Ywxib8ZQGf+AzD6u9roxUJwyx1iEdnqBrdQ339SlKLSMuQmnU5F
	apVRvXWMcRjHiW2/imEhclXMzVeBMQVuDrA3mzELS+vMP55talQPFNBtysgl5/OXKEtgx8ugKQI
	Ow0TQRDWYDTYR76neJIII1kNPTyc=
X-Google-Smtp-Source: AGHT+IExLN+uF9jOIKyPf2rbD5B42EB8fwGKG0mCpQwvNwWWJV2iNXLCm9cdVr3217CoXP8geGjKKfXVBiR0oujjRTY=
X-Received: by 2002:a25:aa85:0:b0:dc6:cf8e:8f97 with SMTP id
 t5-20020a25aa85000000b00dc6cf8e8f97mr1787015ybi.27.1709638338731; Tue, 05 Mar
 2024 03:32:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5c5be485dcfceb44fc731e47758d6be3.legale.legale@gmail.com>
 <12f91b008d6f2b4e6241794d2852c1c84fe6c12c.camel@sipsolutions.net>
 <CZLQMMSSUWBF.1NPJJYDRIXGIR@gmail.com> <37398c88130c487be656eed4e378d6b047a3d612.camel@sipsolutions.net>
In-Reply-To: <37398c88130c487be656eed4e378d6b047a3d612.camel@sipsolutions.net>
From: Isaev Ruslan <legale.legale@gmail.com>
Date: Tue, 5 Mar 2024 14:32:07 +0300
Message-ID: <CACDmYycV9qP2TUMMz5ij75A18NEaVpke6t70r7ELNgV=8+sCRw@mail.gmail.com>
Subject: Re: [PATCH v5] Add JSON output options to 'iw' for scan results
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Nicolas Escande <nico.escande@gmail.com>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 13:31, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2024-03-05 at 11:17 +0100, Nicolas Escande wrote:
>
> > For what it's worth jansson has been very good to me. It has printf() like
> > object creation which usually integrates well with c programs.
>
> Nice :)
>
> > With MIT license https://github.com/akheron/jansson/blob/master/LICENSE
>
> If we link it as a library rather than copying it, that wouldn't even
> matter (well unless it was GPL too, but even then you could still make a
> build without it if you don't want the result to become GPL.)
>
> > For me, having a "good" json representation means, as you pointed out, using the
> > right json underlying type and most of the time I'm afraid that means a complete
> > different code path because of the underlying type/container. It's always a
> > blurry line obviously but duplicating in a complete seperate function that only
> > does the right thing for json output may end up being cleaner codewise.
>
> Yeah, depends, I guess. I'd rather see less duplicating, and in the
> cases like in this patch it seems like it wouldn't even matter so much.
> But agree it depends on the objects.

I think i could make a universal printf() like function with
additional args for json representation.

Something like this:
before:
printf("\t * Manufacturer: %.*s\n", sublen, data + 4);

after:
printf_json("\t * Manufacturer", "%.*s", sublen, data + 4);


void printf_json(const char* key, const char* fmt, ...) {
    char buf[1024];
    va_list args;
    va_start(args, format);

    if (iw_json) {
        vsnprintf(buf, sizeof(buf), format, args);
        print_string(PRINT_JSON, key, "%s", buf);
    } else {
        printf("\t * %s: ", key);
        vprintf(fmt, args);
        printf("\n");
    }

    va_end(args);
}



>
> Just things like
>
>         iw_json ? print_string(PRINT_JSON, "manufacturer", "%.*s", sublen, data + 4) : printf("\t * Manufacturer: %.*s\n", sublen, data + 4);
>
> seem like the worst of both worlds... More obviously perhaps where it's
> not even different:
>
>         iw_json ? print_string(PRINT_JSON, NULL, "FT/IEEE 802.1X") : printf("FT/IEEE 802.1X");
>
> or
>
>         iw_json ? print_string(PRINT_JSON, NULL, "%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]) : printf("%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]);
>
>
> Whereas with something like
>
>         iw_json ? print_string(PRINT_JSON, "response_type", "%d%s", val, val == 3 ? " (AP)" : "") : printf("\t * Response Type: %d%s\n", val, val == 3 ? " (AP)" : "");
>
> (ugh, I don't like those long lines)
>
> you probably don't even want to have the " (AP)" thing in the JSON, but
> make it a real integer type rather than a string with print_string()!
>
> But we could make that
>
>         output_int("response_type", "Response Type", val);
>         if (val == 3)
>                 hint("(AP)");
>
> and the hint() just doesn't do anything in JSON?
>
> And maybe even "response_type" is translated to "Response Type" for the
> human output so you don't need to add the other "Response Type" there.
> Dunno. I really wouldn't mind if in some places that meant we'd now
> output "Response Type" instead of "response type" or "Response type" or
> something.
>
> Or perhaps do it the other way around, so "Response Type" is lower-cased
> and illegal chars like " " are replaced by "_", although that makes the
> JSON representation less obvious in the code.
>
> Picking one arbitrarily, we'd have something
>
>         output_int("Response Type", val);
>         if (val == 3)
>                 hint("(AP)");
>
> which seems far nicer than
>
>         iw_json ? print_string(PRINT_JSON, "response_type", "%d%s", val, val == 3 ? " (AP)" : "") : printf("\t * Response Type: %d%s\n", val, val == 3 ? " (AP)" : "");
>
> in both code and JSON representation.
>
> Yes we'll have to do something about the \n and indentation and I know
> I'm handwaving about that, but it seems like with open_object() and
> close_object() etc. that need to keep a state stack anyway, that should
> be solvable?
>
> I'd argue that we should try to get somewhere around 80-90% of the cases
> unified in this matter, and then have special things for the rest that
> are special kinds of objects, etc.
>
> Right now it's pretty much 100% special cases.
>
> johannes


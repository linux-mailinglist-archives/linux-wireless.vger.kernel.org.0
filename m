Return-Path: <linux-wireless+bounces-26117-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 903FAB19BFA
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 09:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92B1161404
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 07:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E381230BD2;
	Mon,  4 Aug 2025 07:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="JKmgMYdU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8907F1DFE0B
	for <linux-wireless@vger.kernel.org>; Mon,  4 Aug 2025 07:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754291501; cv=none; b=cbZ4NXC2KTbbXqRrvJxFgzOWFJCneZWzcUIHT4dJNbKfc+xWEsxNds0czkFoav4k60jc6BovF7AwaK95A1ih8zp9KK2vskg09RIG11M4VNsQ1Sz4yaV6UhqQ+Pzmii8L355gI1ORBeQBsIwoqWcWrPdz+nHpsL861ao3bQvTvis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754291501; c=relaxed/simple;
	bh=uKJnuFC4T7pT0n1j5poBirFmn/TwVD/VRkxHc16rmQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UjhStDKwQM1BwHIIWDMd8iOUpTlB/LeIK+G6xxtccGK9fi44eNf2MUREAS8Iu/sEU8M30PrvA1Hws4ROcML26pnmQ8jyRNy9+m28DVE/UMEKsCV9Gyv2UhPnvanb94Hm8zzDlKXce8KlPIpD/GSO0QI3GR55aOWy7DysjxLzBh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=JKmgMYdU; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76b8d289f73so2692110b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 04 Aug 2025 00:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1754291499; x=1754896299; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+h6yBC75t0ZFIs2o0xr4fDGCp+qHxzg7XoFol//ZlM=;
        b=JKmgMYdUPQ93kbisu0X8CV/9AbNlk9n7Swc/a+eodOo5VGf6Eq1MvScEp6G+kRQyQ5
         +6KPbrJcq2vvk8XsYIB2Sp+XwusEcxD2JHZuUOpJdm5pu/6ZqublnLy29bQ5aOa8lJkX
         nLKC+nKcRI4kv6YDR7mJWCK2OmmCIGhKjR8DBoL16QACIT7XDCji4cJRg4oNYvpRCNyZ
         SegeHfF73kwtj2P5Keqp80YvdWrkoTPMGt53IVCAMrViUawK23/TY+dr0Gy0LgrwsIuM
         7IciDfSpHwyNGqnnPqUGT+PfB1V6DGGo+ivxhee6QKYx+p7rRQ3PfFHaOiw021ZmRhN3
         Ne+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754291499; x=1754896299;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+h6yBC75t0ZFIs2o0xr4fDGCp+qHxzg7XoFol//ZlM=;
        b=REUL3KKWA6as1c1aLtygBGwyMjYvnadUmetzj9minK/UajvA+hfP8oeVkwnyVgMyIb
         vPSYUuzeE28jwhbs5oT6/BEZEBo3M5fMIJb5qiG9wkXQEp3Y6el3NXU8KdunLsMfZaKN
         79TqlQQZfIalBfN3mI6N1Rmzj4S7TMjy1+eDmvynCFKM8xEV/865NV3iceV7rCe2X6HF
         XpkX2y5PpdF5dIPaIbBC2c5NsDeq79L9ESEnjVPZdqRdqSbWNy6HTkeIg0OF1KoJbLrR
         L77EPKt0Gc3dzElJpt+CP8Zi872UxLQ8ZstbUrMGJOgLHXwiLmyml28S+wT3Qb6AECPu
         /ang==
X-Gm-Message-State: AOJu0YxVnlHbdx3F4ItddRecISNQPaqKweAXlckeVw6euOah+pGmBxuU
	6jy3Cx1lcTQ05Whf34gcU3aDch63DgE6P/0jbKtTrJtZyr8cngt09nWEsH0J0QwsvwQ=
X-Gm-Gg: ASbGnctu4AtUshUwW3Peb2t5s2tu3+wHZX+gRoavA82LdVlOYeOW5rDhTkMoRq27Zo+
	Yu85oUpRVZxZnCqvBX8CzpeY67v6mfHKp6B6SRrPmt/bS1ClibbxHLDWtPqmd7JgbngMf9xvGaB
	VihKpBnJWEO+KdPNMckw7pVCRAEnUpfcDkRNMeA6pCSUIk7b0NXUshRWgYO9UTbwLR73tqFoTHv
	7e/H5W6PqnF7/Q/jeNYBfcQFikTmbEIQTqB41lLpu/1j8vT7vD1YAQzW0b27bzJI9hXcu4tIcpK
	J9wfAapGjEhjSVuJIeS3MF+mFEGiK6MYyHcGqViaD4k89LUTOg8DMOVs/0mGeiJAd4PdPjzStrg
	ORUo8Og9o/oUPTgCUvMHVIVcXKUyV9l0uQRqNAlPtdZzKASwaRSNFJ5AVh7AlGRk=
X-Google-Smtp-Source: AGHT+IGcYjKSQveFUC8pYtYAbTpRoHjRsN/jbcdfI+jdN7PVI1XLAKVdyLRdzge2SRvZvFDy/b6Qgw==
X-Received: by 2002:a05:6a00:a85:b0:736:3ea8:4805 with SMTP id d2e1a72fcca58-76bec314c7dmr9852962b3a.7.1754291498622;
        Mon, 04 Aug 2025 00:11:38 -0700 (PDT)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bdbda5f23sm7506981b3a.112.2025.08.04.00.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 00:11:38 -0700 (PDT)
Date: Mon, 4 Aug 2025 17:11:36 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: [PROPOSAL RFC] S1G Primary Channel Implementation Proposal
Message-ID: <xu4ftmpdwwpokw6exaprrv6wleptq7ggleiluiu6x2dzqbqfhv@6s4m3okiohzw>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Johannes, Wireless,

One of the last remaining pieces within cfg80211/mac80211 to enable
complete S1G functionality is primary channel support. We've identified
a couple of potential implementation specific issues and would like
maintainer input prior to developing the patchset as it may be
mildly contentious.

Background
----------

The channelisation of an S1G PHY consists of two components, a center
frequency and a primary center frequency as per IEEE80211-2024 23.3.14.
The center frequency is equivalent to other PHY types, being the center
operating frequency for the operating channel and the primary center
frequency being the center frequency for the primary channel.

When an S1G PHY changes channel, it requires both the operating channel
and the primary channel parameters. The implementation of this will be
briefly mentioned at the end of this email.

S1G Channel Structure
---------------------

S1G has a hierarchical channel structure. Below is a snippet from the
IEEE80211-2020 Australian/US S1G band. The righthand side |*|
represents the FCC band edge. Above the == line are the designated
channel numbers and on the left column their respective bandwidths.

   |------|---------------------------------------------|*|
 c | 8MHz |  |                  44                   |  |*|
 h |------|---------------------------------------------|*|
 a | 4MHz |  |        40         |        48         |  |*|
 n |------|---------------------------------------------|*|
 n | 2MHz |  |   38    |   42    |   46    |   50    |  |*|
 e |------|---------------------------------------------|*|
 l | 1MHz |  | 37 | 39 | 41 | 43 | 45 | 47 | 49 | 51 |  |*|
   |======|=============================================|*|
   |******| 920  921  922  923  924  925  926  927  928 |*|
   |******|---------------------------------------------|*|
                           frequency (MHz)

S1G Channel Selection Example
-----------------------------

An example channel configuration would be an operating channel of 44 and
a primary channel of 37. The primary channel must be a 1MHz or 2MHz channel
and must exist as a primary subchannel within the operating channels band.
Using the sample above, operating channel 44 can have a 1MHz primary of
37, 39, 41, 43, 45, 47, 49 or 51 and same goes for the 2MHz channels. Whereas
an operating channel of 40 may only have primary 1MHz channels of 37, 39,
41 and 43.

Regulatory Emission Challenges
------------------------------

To control RF emissions during FCC compliance testing, hardware vendors
disable edge-band primary channels to meet emission requirements. [1], [2]
and [3] show 1MHz and 2MHz primary channels on band edges disabled. This,
however, does not prevent the operating channel from being used. This is due
to the OFDM envelope peaking near band centre, providing enough spectrum
roll-off to satisfy emission limits.

Using [3] as an example, primary channels 51, 50 and 49 are disabled during
testing, but operating channels 48 and 44 are still tested (both of which contain
the disabled primary channels). These configurations all passed FCC requirements.

Proposed Solution
-----------------

We propose a new flag within struct ieee80211_channel_flags called
IEEE80211_CHAN_S1G_NO_PRIMARY or something similar that tells the
wireless subsystem that this channel cannot be used as a primary channel,
but is not disabled. This is an important distinction as during subchannel
validation, if a single subchannel is disabled that operating channel cannot
be used (similar to VHT and other PHY types) but an operating channel can
be used if an edgeband 1MHz channel has the NO_PRIMARY flag but is _not_
disabled.

NB: While the existing for_each_subchan macro doesn't work for S1G channels
    given its fixed step size of 20MHz, this will be updated during
    the implementation.

It's also important to note that this can only apply to edgeband primary
channels for the current regdom. This validation will be performed upon
advertisement by the driver of the available channels for the S1G band.
Additionally, puncturing is not supported for S1G.

This will be an implementation detail, as this is not explicitly described
by the standard, but rather used by vendors to ensure FCC compliance.

Primary Channel Representation
------------------------------

One potential challenge with actually implementing primary channel support
is how and where the primary channel is described. Initially it was thought
that a channel definition could contain a separate struct ieee80211_channel
like such:

struct cfg80211_chan_def {
        struct ieee80211_channel *chan;
        [...]
        struct ieee80211_channel *s1g_pri_chan;
};

The obvious problem with this is that now a channel definition describes two
channels, though you could argue that to correctly describe an S1G channel
you require both components - which in some regards makes sense to put them
both in the channel definition. It does, however, require various API changes,
with the biggest one being cfg80211_chandef_create() to accept the new primary
channel parameter. An alternative is to create an S1G specific chandef creation
function which can then call the generic form.

Additionally, we can reuse cfg80211_chandef_valid() to perform validation as
both the operating channel and primary channel exist within the same
channel definition. By extension, many of the function that operate on a
chandef have access to both the primary channel and operating channel.
Definitely something to consider.

The second option is to treat them as two separate channel definitions. This
is probably more "correct" as after all a primary channel is a separate channel.
While this approach doesn't require many major API changes like the previous
method, it still has some negatives. Firstly, the need to carry a separate
channel definition in various places. Taking struct ieee80211_chanctx_conf as
an example:

struct ieee80211_chanctx_conf {
        struct cfg80211_chan_def def;
        [...]
        struct cfg80211_chan_def s1g_pri_def;
};

When building this new channel definition, we probably don't want to be using
_nl80211_parse_chandef() as it relies on the NL80211_ATTR_WIPHY_FREQ to find
the channel, where the primary channel center frequency will rely on a separate
attribute. Now we could, of course, add in another branch to handle this case,
but the function seems fairly overloaded as is and would be good to keep the
S1G specific case separate.

With all that said, we will obviously send up an initial patchset (probably
as an RFC and only once the TIM patchset has been accepted) but since we are
inquiring with regards to the new flag thought it couldn't hurt to get some
preliminary thoughts.

References
----------

[1] AsiaRF MM610X-001 FCC Radio Test Report
    Section 1.1.1
    https://fccid.io/TKZMM610X-001/Test-Report/TKZMM610X-001-Test-Rpt-6686112.pdf

[2] Silex Technology SX-NEWAH FCC Radio Test Report
    Section 2.2
    https://fccid.io/N6C-SXNEWAH/Test-Report/03-FCC-Test-Report-DTS-4734386.pdf

[3] Morse Micro MM6108-MF08651-US Electromagnetic Emissions Compliance Report
    Page 35
    https://fccid.io/2A74O-DB3F2B/Test-Report/TR-TERF2406001545E2-902-928MHz-s03-part-1-7640840

lachlan


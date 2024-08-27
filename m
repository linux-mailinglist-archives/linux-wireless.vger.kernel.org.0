Return-Path: <linux-wireless+bounces-12096-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFFC9617C0
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 21:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6073D283A19
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 19:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621CF148FE5;
	Tue, 27 Aug 2024 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="FjGne4If"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5E881AD2
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785764; cv=none; b=U0nz0Etd1DmfI9qRg1NXhe+VM77fceQ7L7ylyVGE5Nt2FqAoYrTNWL1I+1GLoNjMIDEBP2oevqDhU6VgODI/axzXoGHHu2OwYzdGAfj+jvEpoIZeSRc5xJnBQb1Udle7aB7n7AQQcvttINNIQzn7nPZwuPG0UCndNsZY/05N8UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785764; c=relaxed/simple;
	bh=pJjIDbP04AtgOM9Mt266JsaUj0wI9Ibeg99AFGziXEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q78HXDzisfVgb/PrPGsq4HOwmi1Q5RwAzoqjMD9Ru0MjeKz806bLr4+VedLkmyNkmPSVKMvVHIKgeTwbUVNGIaUgtmT8M3oUkC9IdR7T8G8a3YDPbDKXWlvieY0S3nlWp+gTCs8ZdV4Tm2Sr2fVYu1qxMcUxLWbB3GwspPNAlcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=FjGne4If; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-454e92f001eso33085971cf.0
        for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 12:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1724785760; x=1725390560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oe+2uNhH/B3pceahyKtM1sRea4Ox34K7FMMHw8bfaKE=;
        b=FjGne4IfMYJoeX6veEl7KPdlckE9o752ndufH1y5UT2G40/P5x/Z11MEafnA2qdhB3
         zLf1grRamttpfS/sX6wFYVRkZFNxr0PisCMeewu3Rs6DP7D1DA+tGGnfk0AlDUfLq3ND
         o8a7Hh3q2IZeePds0ZFRqdrRZstO2fMSLeMgTBp9rkzvc6fxj0mQn4xyyzO2/4jdcTsF
         845iL2FxkkTOpHk7f9A811EvJGWhIjygnOfTpm8spU4b8AT9BwK7gsfKClVmNLhJbTvE
         uHoOf2cr+uw++iqlLYReqrpOKdRroVL93A8uBQ8jjYHXTDVV+jh1g2K7qEZWAutPXsfP
         Yqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724785760; x=1725390560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oe+2uNhH/B3pceahyKtM1sRea4Ox34K7FMMHw8bfaKE=;
        b=lmL7R3TG5atXFc52IQPbGviAqf0s6/BBXZ7Fi0r4tOomXZQFCuJibGWeUKz+zDlK0j
         5Tt7oFvcIR19dHmYhKfONKdYaJUCVhu8Bp+VHD78ECAJQtWCn9LXOmdbcePutG9CII8q
         bn+1StIvHi1jj1wIeoZ4+9rqCdty7QkuiVzM9Koc+thP+DR08Og0cvqCTESRViwXWNwh
         gpU6yxUDRFDReMD3Gw/YjXRfHZPuknwzKjqhjFdS0KSYysOfmC6EoMxcCd+moJducWan
         iK/aOhvEneeuL8o2nvCSsHIK/u8iajUctMXXi5gQajbigJ86YUwQSDoS3FU+9zFSzmv1
         +R6w==
X-Gm-Message-State: AOJu0Yze52852eaFiGKRBt2O4pj48T/45ulh7rImOhw1DdZsZSVT2apc
	kGKsC70z98JyFBLIz8nHgCJW9E8h3KYVggyotUO3kLUixTpIlsOay1970NXgVKqUi3W/673KQMG
	Z/KXj
X-Google-Smtp-Source: AGHT+IHpeGuFe3gW7p1DmBKm8NwoY5jPT8rY709kkVLg2+4mTj9yXumriuFOw/IfU7kDJ+PQEhroSA==
X-Received: by 2002:a05:622a:4896:b0:447:f89a:4d41 with SMTP id d75a77b69052e-45509c78965mr199406171cf.30.1724785759367;
        Tue, 27 Aug 2024 12:09:19 -0700 (PDT)
Received: from rowland.harvard.edu (nat-65-112-8-18.harvard-secure.wrls.harvard.edu. [65.112.8.18])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe0f04adsm55886361cf.43.2024.08.27.12.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 12:09:17 -0700 (PDT)
Date: Tue, 27 Aug 2024 15:09:14 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, hostap@lists.infradead.org
Subject: Re: WiFi constantly changes association
Message-ID: <9cd7bc93-090a-4fcd-9af1-af6ff108064b@rowland.harvard.edu>
References: <eb86cf20-2b1b-4871-82a4-441ba81752dc@rowland.harvard.edu>
 <9f32e4ff8b59f137208d99c40fd166f81e8de4bc.camel@sipsolutions.net>
 <52752800050fdd10e3d883cb4870624455d1b34e.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52752800050fdd10e3d883cb4870624455d1b34e.camel@sipsolutions.net>

On Mon, Aug 26, 2024 at 09:19:46PM +0200, Johannes Berg wrote:
> On Mon, 2024-08-26 at 21:14 +0200, Johannes Berg wrote:
> > On Mon, 2024-08-26 at 15:06 -0400, Alan Stern wrote:
> > > 
> > > Is there any way to debug those INVALID_TE and PREV_AUTH_NOT_VALID errors?
> > > 
> > 
> > The kernel doesn't use those codes for its own deauth, if that were to
> > happen, so you'll want to look at the wpa_supplicant log, perhaps
> > increasing the logging verbosity for it (I think how to do that probably
> > depends on the distro, and I don't know off the top of my head.)
> > 
> 
> Then again, while what I said is still true, reading the log more
> carefully shows that wpa_s decided to roam and then got into those bad
> situations that caused it to deauth. So you'd want to figure out why it
> decides to roam there.
> 
> Or perhaps roaming would be OK, if it weren't for the failures during
> it.

Well, I'd prefer to avoid unnecessary roaming because of the short 
interruptions in service that it causes.

Below is an extract from the system log for a period of about two 
minutes, running with wpa_supplicant's -dd option set for verbose 
debugging.  As of the start of the extract, the system had been 
associated with an AP for about five minutes.  The log shows a few 
spontaneous reassociations and some errors.  I hardly understand any of 
it, so thanks for your efforts to make sense of what it shows.

Alan


Aug 27 14:48:56 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:81:97:41 1
Aug 27 14:48:56 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:81:ac:33 1
Aug 27 14:48:56 strephon wpa_supplicant[5906]: wlan0: SME: Trying to authenticate with 48:b4:c3:81:b7:d3 (SSID='Harvard Secure' freq=6535 MHz)
Aug 27 14:48:56 strephon kernel: wlan0: disconnect from AP 48:b4:c3:81:b8:03 for new auth to 48:b4:c3:81:b7:d3
Aug 27 14:48:56 strephon kernel: wlan0: authenticate with 48:b4:c3:81:b7:d3 (local address=3e:de:7e:33:e6:22)
Aug 27 14:48:56 strephon kernel: wlan0: send auth to 48:b4:c3:81:b7:d3 (try 1/3)
Aug 27 14:48:56 strephon NetworkManager[978]: <info>  [1724784536.8123] device (wlan0): supplicant interface state: completed -> authenticating
Aug 27 14:48:56 strephon NetworkManager[978]: <info>  [1724784536.8124] device (p2p-dev-wlan0): supplicant management interface state: completed -> authenticating
Aug 27 14:48:56 strephon kernel: wlan0: authenticated
Aug 27 14:48:56 strephon kernel: wlan0: associate with 48:b4:c3:81:b7:d3 (try 1/3)
Aug 27 14:48:56 strephon wpa_supplicant[5906]: nl80211: kernel reports: key not allowed
Aug 27 14:48:56 strephon wpa_supplicant[5906]: FT: Failed to set PTK to the driver
Aug 27 14:48:56 strephon wpa_supplicant[5906]: wlan0: Trying to associate with 48:b4:c3:81:b7:d3 (SSID='Harvard Secure' freq=6535 MHz)
Aug 27 14:48:56 strephon kernel: wlan0: RX ReassocResp from 48:b4:c3:81:b7:d3 (capab=0x11 status=0 aid=16)
Aug 27 14:48:56 strephon NetworkManager[978]: <info>  [1724784536.8326] device (wlan0): supplicant interface state: authenticating -> associating
Aug 27 14:48:56 strephon NetworkManager[978]: <info>  [1724784536.8326] device (p2p-dev-wlan0): supplicant management interface state: authenticating -> associating
Aug 27 14:48:56 strephon kernel: wlan0: associated
Aug 27 14:48:56 strephon kernel: wlan0: deauthenticating from 48:b4:c3:81:b7:d3 by local choice (Reason: 13=INVALID_IE)
Aug 27 14:48:56 strephon wpa_supplicant[5906]: wlan0: FT: RSNE mismatch between Beacon/ProbeResp and FT protocol Reassociation Response frame
Aug 27 14:48:56 strephon wpa_supplicant[5906]: RSNE in Beacon/ProbeResp - hexdump(len=32): 30 1e 01 00 00 0f ac 04 01 00 00 0f ac 04 02 00 00 0f ac 05 00 0f ac 03 e8 00 00 00 00 0f ac 06
Aug 27 14:48:56 strephon wpa_supplicant[5906]: RSNE in FT protocol Reassociation Response frame - hexdump(len=44): 30 2a 01 00 00 0f ac 04 01 00 00 0f ac 04 02 00 00 0f ac 01 00 0f ac 03 e8 00 01 00 ff 84 62 84 5a a3 06 82 4f b4 2d 43 36 76 87 4b
Aug 27 14:48:56 strephon kernel: iwlwifi 0000:72:00.0: Unhandled alg: 0x707
Aug 27 14:48:56 strephon kernel: iwlwifi 0000:72:00.0: Unhandled alg: 0x707
Aug 27 14:48:56 strephon wpa_supplicant[5906]: nl80211: send_event_marker failed: Source based routing not supported
Aug 27 14:48:56 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-DISCONNECTED bssid=48:b4:c3:81:b7:d3 reason=13 locally_generated=1
Aug 27 14:48:56 strephon wpa_supplicant[5906]: wlan0: BSSID 48:b4:c3:81:b7:d3 ignore list count incremented to 3, ignoring for 60 seconds
Aug 27 14:48:56 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-DSCP-POLICY clear_all
Aug 27 14:48:56 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-SUBNET-STATUS-UPDATE status=0
Aug 27 14:48:56 strephon NetworkManager[978]: <info>  [1724784536.8677] device (wlan0): supplicant interface state: associating -> disconnected
Aug 27 14:48:56 strephon NetworkManager[978]: <info>  [1724784536.8678] device (p2p-dev-wlan0): supplicant management interface state: associating -> disconnected
Aug 27 14:48:56 strephon NetworkManager[978]: <info>  [1724784536.9676] device (wlan0): supplicant interface state: disconnected -> scanning
Aug 27 14:48:56 strephon NetworkManager[978]: <info>  [1724784536.9677] device (p2p-dev-wlan0): supplicant management interface state: disconnected -> scanning
Aug 27 14:49:00 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:81:b7:e3 1
Aug 27 14:49:00 strephon wpa_supplicant[5906]: wlan0: SME: Trying to authenticate with 48:b4:c3:81:b8:03 (SSID='Harvard Secure' freq=6215 MHz)
Aug 27 14:49:00 strephon kernel: wlan0: authenticate with 48:b4:c3:81:b8:03 (local address=3e:de:7e:33:e6:22)
Aug 27 14:49:00 strephon kernel: wlan0: send auth to 48:b4:c3:81:b8:03 (try 1/3)
Aug 27 14:49:00 strephon NetworkManager[978]: <info>  [1724784540.4148] device (wlan0): supplicant interface state: scanning -> authenticating
Aug 27 14:49:00 strephon NetworkManager[978]: <info>  [1724784540.4148] device (p2p-dev-wlan0): supplicant management interface state: scanning -> authenticating
Aug 27 14:49:00 strephon kernel: wlan0: authenticated
Aug 27 14:49:00 strephon wpa_supplicant[5906]: wlan0: Trying to associate with 48:b4:c3:81:b8:03 (SSID='Harvard Secure' freq=6215 MHz)
Aug 27 14:49:00 strephon NetworkManager[978]: <info>  [1724784540.4170] device (wlan0): supplicant interface state: authenticating -> associating
Aug 27 14:49:00 strephon NetworkManager[978]: <info>  [1724784540.4170] device (p2p-dev-wlan0): supplicant management interface state: authenticating -> associating
Aug 27 14:49:00 strephon kernel: wlan0: associate with 48:b4:c3:81:b8:03 (try 1/3)
Aug 27 14:49:00 strephon kernel: iwlwifi 0000:72:00.0: Unhandled alg: 0x707
Aug 27 14:49:00 strephon kernel: wlan0: RX AssocResp from 48:b4:c3:81:b8:03 (capab=0x1 status=30 aid=0)
Aug 27 14:49:00 strephon kernel: wlan0: 48:b4:c3:81:b8:03 rejected association temporarily; comeback duration 4882 TU (4999 ms)
Aug 27 14:49:05 strephon kernel: wlan0: aborting association with 48:b4:c3:81:b8:03 by local choice (Reason: 3=DEAUTH_LEAVING)
Aug 27 14:49:05 strephon wpa_supplicant[5906]: nl80211: send_event_marker failed: Source based routing not supported
Aug 27 14:49:05 strephon wpa_supplicant[5906]: wlan0: Added BSSID 48:b4:c3:81:b8:03 into ignore list, ignoring for 10 seconds
Aug 27 14:49:05 strephon wpa_supplicant[5906]: wlan0: BSSID 48:b4:c3:81:b8:03 ignore list count incremented to 2, ignoring for 10 seconds
Aug 27 14:49:05 strephon NetworkManager[978]: <info>  [1724784545.4458] device (wlan0): supplicant interface state: associating -> disconnected
Aug 27 14:49:05 strephon NetworkManager[978]: <info>  [1724784545.4459] device (p2p-dev-wlan0): supplicant management interface state: associating -> disconnected
Aug 27 14:49:05 strephon NetworkManager[978]: <info>  [1724784545.9462] device (wlan0): supplicant interface state: disconnected -> scanning
Aug 27 14:49:05 strephon NetworkManager[978]: <info>  [1724784545.9463] device (p2p-dev-wlan0): supplicant management interface state: disconnected -> scanning
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: SME: Trying to authenticate with 48:b4:c3:81:b1:a0 (SSID='Harvard Secure' freq=5975 MHz)
Aug 27 14:49:06 strephon kernel: wlan0: authenticate with 48:b4:c3:81:b1:a0 (local address=3e:de:7e:33:e6:22)
Aug 27 14:49:06 strephon kernel: wlan0: send auth to 48:b4:c3:81:b1:a0 (try 1/3)
Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.5417] device (wlan0): supplicant interface state: scanning -> authenticating
Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.5417] device (p2p-dev-wlan0): supplicant management interface state: scanning -> authenticating
Aug 27 14:49:06 strephon kernel: wlan0: authenticated
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: Trying to associate with 48:b4:c3:81:b1:a0 (SSID='Harvard Secure' freq=5975 MHz)
Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.5504] device (wlan0): supplicant interface state: authenticating -> associating
Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.5505] device (p2p-dev-wlan0): supplicant management interface state: authenticating -> associating
Aug 27 14:49:06 strephon kernel: wlan0: associate with 48:b4:c3:81:b1:a0 (try 1/3)
Aug 27 14:49:06 strephon kernel: wlan0: RX AssocResp from 48:b4:c3:81:b1:a0 (capab=0x111 status=0 aid=17)
Aug 27 14:49:06 strephon kernel: wlan0: associated
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: Associated with 48:b4:c3:81:b1:a0
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-STARTED EAP authentication started
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-SUBNET-STATUS-UPDATE status=0
Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.5694] device (wlan0): supplicant interface state: associating -> associated
Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.5695] device (p2p-dev-wlan0): supplicant management interface state: associating -> associated
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-PROPOSED-METHOD vendor=0 method=13
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-METHOD EAP vendor 0 method 13 (TLS) selected
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-PEER-CERT depth=2 subject='/C=US/ST=New Jersey/L=Jersey City/O=The USERTRUST Network/CN=USERTrust RSA Certification Authority' hash=e793c9b02fd8aa13e21c31228accb08119643b749c898964b1746d46c3d4cbd2
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-PEER-CERT depth=1 subject='/C=US/O=Internet2/CN=InCommon RSA Server CA 2' hash=87e01cc4dd0c9d92a3dbd49092ff13f9cd387445cdc57e5b984e1b7721b5b029
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-PEER-CERT depth=0 subject='/C=US/ST=Massachusetts/O=President and Fellows of Harvard College/CN=getonline.noc.harvard.edu' hash=3f49c12863e8b1acf739e8ab4c55e165d9466d1ba18287d0ef1ffa1e743a3d88
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-PEER-ALT depth=0 DNS:getonline.noc.harvard.edu
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-PEER-ALT depth=0 DNS:autoreg.fas.harvard.edu
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-PEER-ALT depth=0 DNS:autoreg1-10wa.noc.harvard.edu
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-PEER-ALT depth=0 DNS:autoreg1-60ox.noc.harvard.edu
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-PEER-ALT depth=0 DNS:getonline.harvard.edu
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-PEER-ALT depth=0 DNS:registration.noc.harvard.edu
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-PEER-ALT depth=0 DNS:sc-cppm-pub1.net.harvard.edu
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-PEER-ALT depth=0 DNS:sc-cppm-sub1.net.harvard.edu
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-PEER-ALT depth=0 DNS:sc-cppm-sub10.net.harvard.edu
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-PEER-ALT depth=0 DNS:sc-cppm-sub11.net.harvard.edu
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-SUCCESS EAP authentication completed successfully
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:81:b1:a0 1
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:81:b1:a0 1
Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.8164] device (wlan0): supplicant interface state: associated -> 4way_handshake
Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.8165] device (p2p-dev-wlan0): supplicant management interface state: associated -> 4way_handshake
Aug 27 14:49:06 strephon kernel: iwlwifi 0000:72:00.0: Unhandled alg: 0x707
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: WPA: Key negotiation completed with 48:b4:c3:81:b1:a0 [PTK=CCMP GTK=CCMP]
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-CONNECTED - Connection to 48:b4:c3:81:b1:a0 completed [id=1 id_str=]
Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.8649] device (wlan0): supplicant interface state: 4way_handshake -> completed
Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-68 noise=9999 txrate=29200
Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.8660] device (wlan0): ip:dhcp4: restarting
Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.8660] dhcp4 (wlan0): canceled DHCP transaction
Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.8660] dhcp4 (wlan0): activation: beginning transaction (timeout in 45 seconds)
Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.8660] dhcp4 (wlan0): state changed no lease
Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.8661] dhcp4 (wlan0): activation: beginning transaction (timeout in 45 seconds)
Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.8661] device (p2p-dev-wlan0): supplicant management interface state: 4way_handshake -> completed
Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.9397] dhcp4 (wlan0): state changed new lease, address=10.250.66.194, acd pending
Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.9401] dhcp4 (wlan0): state changed new lease, address=10.250.66.194
Aug 27 14:49:06 strephon systemd[1]: Starting NetworkManager-dispatcher.service - Network Manager Script Dispatcher Service...
Aug 27 14:49:06 strephon systemd[1]: Started NetworkManager-dispatcher.service - Network Manager Script Dispatcher Service.
Aug 27 14:49:17 strephon systemd[1]: NetworkManager-dispatcher.service: Deactivated successfully.
Aug 27 14:49:41 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:80:58:a1 1
Aug 27 14:49:41 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:81:c8:e2 1
Aug 27 14:49:41 strephon wpa_supplicant[5906]: wlan0: SME: Trying to authenticate with 48:b4:c3:81:b8:03 (SSID='Harvard Secure' freq=6215 MHz)
Aug 27 14:49:41 strephon kernel: wlan0: disconnect from AP 48:b4:c3:81:b1:a0 for new auth to 48:b4:c3:81:b8:03
Aug 27 14:49:41 strephon kernel: wlan0: authenticate with 48:b4:c3:81:b8:03 (local address=3e:de:7e:33:e6:22)
Aug 27 14:49:41 strephon kernel: wlan0: send auth to 48:b4:c3:81:b8:03 (try 1/3)
Aug 27 14:49:41 strephon NetworkManager[978]: <info>  [1724784581.2208] device (wlan0): supplicant interface state: completed -> authenticating
Aug 27 14:49:41 strephon NetworkManager[978]: <info>  [1724784581.2209] device (p2p-dev-wlan0): supplicant management interface state: completed -> authenticating
Aug 27 14:49:41 strephon kernel: wlan0: authenticated
Aug 27 14:49:41 strephon wpa_supplicant[5906]: nl80211: kernel reports: key not allowed
Aug 27 14:49:41 strephon wpa_supplicant[5906]: FT: Failed to set PTK to the driver
Aug 27 14:49:41 strephon wpa_supplicant[5906]: wlan0: Trying to associate with 48:b4:c3:81:b8:03 (SSID='Harvard Secure' freq=6215 MHz)
Aug 27 14:49:41 strephon kernel: wlan0: associate with 48:b4:c3:81:b8:03 (try 1/3)
Aug 27 14:49:41 strephon NetworkManager[978]: <info>  [1724784581.2321] device (wlan0): supplicant interface state: authenticating -> associating
Aug 27 14:49:41 strephon NetworkManager[978]: <info>  [1724784581.2322] device (p2p-dev-wlan0): supplicant management interface state: authenticating -> associating
Aug 27 14:49:41 strephon kernel: wlan0: RX ReassocResp from 48:b4:c3:81:b8:03 (capab=0x11 status=0 aid=17)
Aug 27 14:49:41 strephon kernel: wlan0: associated
Aug 27 14:49:41 strephon kernel: wlan0: deauthenticating from 48:b4:c3:81:b8:03 by local choice (Reason: 13=INVALID_IE)
Aug 27 14:49:41 strephon wpa_supplicant[5906]: wlan0: FT: RSNE mismatch between Beacon/ProbeResp and FT protocol Reassociation Response frame
Aug 27 14:49:41 strephon wpa_supplicant[5906]: RSNE in Beacon/ProbeResp - hexdump(len=32): 30 1e 01 00 00 0f ac 04 01 00 00 0f ac 04 02 00 00 0f ac 05 00 0f ac 03 e8 00 00 00 00 0f ac 06
Aug 27 14:49:41 strephon wpa_supplicant[5906]: RSNE in FT protocol Reassociation Response frame - hexdump(len=44): 30 2a 01 00 00 0f ac 04 01 00 00 0f ac 04 02 00 00 0f ac 01 00 0f ac 03 e8 00 01 00 8c 34 e8 c2 21 bb 8a 04 04 fa 5b bb 29 23 ed eb
Aug 27 14:49:41 strephon kernel: iwlwifi 0000:72:00.0: Unhandled alg: 0x707
Aug 27 14:49:41 strephon wpa_supplicant[5906]: nl80211: send_event_marker failed: Source based routing not supported
Aug 27 14:49:41 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-DISCONNECTED bssid=48:b4:c3:81:b8:03 reason=13 locally_generated=1
Aug 27 14:49:41 strephon wpa_supplicant[5906]: wlan0: BSSID 48:b4:c3:81:b8:03 ignore list count incremented to 3, ignoring for 60 seconds
Aug 27 14:49:41 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-DSCP-POLICY clear_all
Aug 27 14:49:41 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-SUBNET-STATUS-UPDATE status=0
Aug 27 14:49:41 strephon NetworkManager[978]: <info>  [1724784581.2793] device (wlan0): supplicant interface state: associating -> disconnected
Aug 27 14:49:41 strephon NetworkManager[978]: <info>  [1724784581.2794] device (p2p-dev-wlan0): supplicant management interface state: associating -> disconnected
Aug 27 14:49:41 strephon NetworkManager[978]: <info>  [1724784581.3794] device (wlan0): supplicant interface state: disconnected -> scanning
Aug 27 14:49:41 strephon NetworkManager[978]: <info>  [1724784581.3795] device (p2p-dev-wlan0): supplicant management interface state: disconnected -> scanning
Aug 27 14:49:44 strephon wpa_supplicant[5906]: wlan0: SME: Trying to authenticate with 48:b4:c3:81:b1:a0 (SSID='Harvard Secure' freq=5975 MHz)
Aug 27 14:49:44 strephon kernel: wlan0: authenticate with 48:b4:c3:81:b1:a0 (local address=3e:de:7e:33:e6:22)
Aug 27 14:49:44 strephon kernel: wlan0: send auth to 48:b4:c3:81:b1:a0 (try 1/3)
Aug 27 14:49:44 strephon NetworkManager[978]: <info>  [1724784584.7189] device (wlan0): supplicant interface state: scanning -> authenticating
Aug 27 14:49:44 strephon NetworkManager[978]: <info>  [1724784584.7189] device (p2p-dev-wlan0): supplicant management interface state: scanning -> authenticating
Aug 27 14:49:44 strephon kernel: wlan0: authenticated
Aug 27 14:49:44 strephon wpa_supplicant[5906]: wlan0: Trying to associate with 48:b4:c3:81:b1:a0 (SSID='Harvard Secure' freq=5975 MHz)
Aug 27 14:49:44 strephon NetworkManager[978]: <info>  [1724784584.7253] device (wlan0): supplicant interface state: authenticating -> associating
Aug 27 14:49:44 strephon NetworkManager[978]: <info>  [1724784584.7254] device (p2p-dev-wlan0): supplicant management interface state: authenticating -> associating
Aug 27 14:49:44 strephon kernel: wlan0: associate with 48:b4:c3:81:b1:a0 (try 1/3)
Aug 27 14:49:44 strephon kernel: wlan0: RX AssocResp from 48:b4:c3:81:b1:a0 (capab=0x111 status=0 aid=17)
Aug 27 14:49:44 strephon kernel: wlan0: associated
Aug 27 14:49:44 strephon wpa_supplicant[5906]: wlan0: Associated with 48:b4:c3:81:b1:a0
Aug 27 14:49:44 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-STARTED EAP authentication started
Aug 27 14:49:44 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-SUBNET-STATUS-UPDATE status=0
Aug 27 14:49:44 strephon NetworkManager[978]: <info>  [1724784584.7446] device (wlan0): supplicant interface state: associating -> associated
Aug 27 14:49:44 strephon NetworkManager[978]: <info>  [1724784584.7447] device (p2p-dev-wlan0): supplicant management interface state: associating -> associated
Aug 27 14:49:44 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-PROPOSED-METHOD vendor=0 method=13
Aug 27 14:49:44 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-METHOD EAP vendor 0 method 13 (TLS) selected
Aug 27 14:49:44 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-SUCCESS EAP authentication completed successfully
Aug 27 14:49:44 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:81:b1:a0 1
Aug 27 14:49:44 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:81:b1:a0 1
Aug 27 14:49:44 strephon NetworkManager[978]: <info>  [1724784584.8524] device (wlan0): supplicant interface state: associated -> 4way_handshake
Aug 27 14:49:44 strephon NetworkManager[978]: <info>  [1724784584.8525] device (p2p-dev-wlan0): supplicant management interface state: associated -> 4way_handshake
Aug 27 14:49:44 strephon wpa_supplicant[5906]: wlan0: WPA: Key negotiation completed with 48:b4:c3:81:b1:a0 [PTK=CCMP GTK=CCMP]
Aug 27 14:49:44 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-CONNECTED - Connection to 48:b4:c3:81:b1:a0 completed [id=1 id_str=]
Aug 27 14:49:44 strephon NetworkManager[978]: <info>  [1724784584.9010] device (wlan0): supplicant interface state: 4way_handshake -> completed
Aug 27 14:49:44 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-66 noise=9999 txrate=29200
Aug 27 14:49:44 strephon NetworkManager[978]: <info>  [1724784584.9021] device (wlan0): ip:dhcp4: restarting
Aug 27 14:49:44 strephon NetworkManager[978]: <info>  [1724784584.9022] dhcp4 (wlan0): canceled DHCP transaction
Aug 27 14:49:44 strephon NetworkManager[978]: <info>  [1724784584.9022] dhcp4 (wlan0): activation: beginning transaction (timeout in 45 seconds)
Aug 27 14:49:44 strephon NetworkManager[978]: <info>  [1724784584.9022] dhcp4 (wlan0): state changed no lease
Aug 27 14:49:44 strephon NetworkManager[978]: <info>  [1724784584.9023] dhcp4 (wlan0): activation: beginning transaction (timeout in 45 seconds)
Aug 27 14:49:44 strephon NetworkManager[978]: <info>  [1724784584.9024] device (p2p-dev-wlan0): supplicant management interface state: 4way_handshake -> completed
Aug 27 14:49:46 strephon NetworkManager[978]: <info>  [1724784586.9194] dhcp4 (wlan0): state changed new lease, address=10.250.66.194, acd pending
Aug 27 14:49:46 strephon NetworkManager[978]: <info>  [1724784586.9197] dhcp4 (wlan0): state changed new lease, address=10.250.66.194
Aug 27 14:49:46 strephon systemd[1]: Starting NetworkManager-dispatcher.service - Network Manager Script Dispatcher Service...
Aug 27 14:49:46 strephon systemd[1]: Started NetworkManager-dispatcher.service - Network Manager Script Dispatcher Service.
Aug 27 14:49:53 strephon kernel: wlan0: deauthenticating from 48:b4:c3:81:b1:a0 by local choice (Reason: 2=PREV_AUTH_NOT_VALID)
Aug 27 14:49:54 strephon wpa_supplicant[5906]: nl80211: send_event_marker failed: Source based routing not supported
Aug 27 14:49:54 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-DISCONNECTED bssid=48:b4:c3:81:b1:a0 reason=2 locally_generated=1
Aug 27 14:49:54 strephon wpa_supplicant[5906]: wlan0: Added BSSID 48:b4:c3:81:b1:a0 into ignore list, ignoring for 10 seconds
Aug 27 14:49:54 strephon wpa_supplicant[5906]: wlan0: BSSID 48:b4:c3:81:b1:a0 ignore list count incremented to 2, ignoring for 10 seconds
Aug 27 14:49:54 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-DSCP-POLICY clear_all
Aug 27 14:49:54 strephon NetworkManager[978]: <info>  [1724784594.0228] device (wlan0): supplicant interface state: completed -> disconnected
Aug 27 14:49:54 strephon NetworkManager[978]: <info>  [1724784594.0229] device (p2p-dev-wlan0): supplicant management interface state: completed -> disconnected
Aug 27 14:49:54 strephon NetworkManager[978]: <info>  [1724784594.1210] device (wlan0): supplicant interface state: disconnected -> scanning
Aug 27 14:49:54 strephon NetworkManager[978]: <info>  [1724784594.1210] device (p2p-dev-wlan0): supplicant management interface state: disconnected -> scanning
Aug 27 14:49:54 strephon wpa_supplicant[5906]: wlan0: SME: Trying to authenticate with 48:b4:c3:81:b7:b3 (SSID='Harvard Secure' freq=5220 MHz)
Aug 27 14:49:54 strephon kernel: wlan0: authenticate with 48:b4:c3:81:b7:b3 (local address=3e:de:7e:33:e6:22)
Aug 27 14:49:54 strephon kernel: wlan0: send auth to 48:b4:c3:81:b7:b3 (try 1/3)
Aug 27 14:49:54 strephon wpa_supplicant[5906]: wlan0: Trying to associate with 48:b4:c3:81:b7:b3 (SSID='Harvard Secure' freq=5220 MHz)
Aug 27 14:49:54 strephon kernel: wlan0: authenticated
Aug 27 14:49:54 strephon kernel: wlan0: associate with 48:b4:c3:81:b7:b3 (try 1/3)
Aug 27 14:49:54 strephon NetworkManager[978]: <info>  [1724784594.9699] device (wlan0): supplicant interface state: scanning -> associating
Aug 27 14:49:54 strephon NetworkManager[978]: <info>  [1724784594.9699] device (p2p-dev-wlan0): supplicant management interface state: scanning -> associating
Aug 27 14:49:54 strephon kernel: wlan0: RX AssocResp from 48:b4:c3:81:b7:b3 (capab=0x1111 status=0 aid=3)
Aug 27 14:49:54 strephon kernel: wlan0: associated
Aug 27 14:49:54 strephon wpa_supplicant[5906]: wlan0: Associated with 48:b4:c3:81:b7:b3
Aug 27 14:49:54 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-STARTED EAP authentication started
Aug 27 14:49:54 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-SUBNET-STATUS-UPDATE status=0
Aug 27 14:49:54 strephon NetworkManager[978]: <info>  [1724784594.9854] device (wlan0): supplicant interface state: associating -> associated
Aug 27 14:49:54 strephon NetworkManager[978]: <info>  [1724784594.9855] device (p2p-dev-wlan0): supplicant management interface state: associating -> associated
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-PROPOSED-METHOD vendor=0 method=13
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-METHOD EAP vendor 0 method 13 (TLS) selected
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-SUCCESS EAP authentication completed successfully
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:81:b7:d3 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:81:b7:c3 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED e8:10:98:7c:2d:42 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 54:d7:e3:d9:91:22 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:81:b1:80 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED e8:10:98:7c:2d:52 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:81:b7:f3 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:81:b1:90 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:81:af:c3 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED dc:b7:ac:e3:18:b1 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED dc:b7:ac:e3:18:a1 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:81:c7:93 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:81:cc:33 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 54:d7:e3:d9:91:32 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 54:d7:e3:d9:91:12 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:4a:e9:c1:6c:31 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:81:af:a3 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:81:97:51 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:81:c8:c2 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:81:c8:d2 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:81:ac:23 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:81:c1:b2 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:81:c7:83 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:81:af:b3 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:81:97:41 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:81:ac:33 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:81:b7:e3 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:80:58:a1 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:81:c8:e2 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:81:b7:b3 1
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:81:b7:b3 1
Aug 27 14:49:55 strephon NetworkManager[978]: <info>  [1724784595.0976] device (wlan0): supplicant interface state: associated -> 4way_handshake
Aug 27 14:49:55 strephon NetworkManager[978]: <info>  [1724784595.0976] device (p2p-dev-wlan0): supplicant management interface state: associated -> 4way_handshake
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: WPA: Key negotiation completed with 48:b4:c3:81:b7:b3 [PTK=CCMP GTK=CCMP]
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-CONNECTED - Connection to 48:b4:c3:81:b7:b3 completed [id=1 id_str=]
Aug 27 14:49:55 strephon NetworkManager[978]: <info>  [1724784595.1426] device (wlan0): supplicant interface state: 4way_handshake -> completed
Aug 27 14:49:55 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-40 noise=9999 txrate=58500
Aug 27 14:49:55 strephon NetworkManager[978]: <info>  [1724784595.1431] device (wlan0): ip:dhcp4: restarting
Aug 27 14:49:55 strephon NetworkManager[978]: <info>  [1724784595.1498] dhcp4 (wlan0): canceled DHCP transaction
Aug 27 14:49:55 strephon NetworkManager[978]: <info>  [1724784595.1498] dhcp4 (wlan0): activation: beginning transaction (timeout in 45 seconds)
Aug 27 14:49:55 strephon NetworkManager[978]: <info>  [1724784595.1498] dhcp4 (wlan0): state changed no lease
Aug 27 14:49:55 strephon NetworkManager[978]: <info>  [1724784595.1499] dhcp4 (wlan0): activation: beginning transaction (timeout in 45 seconds)
Aug 27 14:49:55 strephon NetworkManager[978]: <info>  [1724784595.1501] device (p2p-dev-wlan0): supplicant management interface state: 4way_handshake -> completed
Aug 27 14:49:55 strephon NetworkManager[978]: <info>  [1724784595.1609] dhcp4 (wlan0): state changed new lease, address=10.250.66.194, acd pending
Aug 27 14:49:55 strephon NetworkManager[978]: <info>  [1724784595.1610] dhcp4 (wlan0): state changed new lease, address=10.250.66.194
Aug 27 14:50:02 strephon kernel: wlan0: deauthenticating from 48:b4:c3:81:b7:b3 by local choice (Reason: 2=PREV_AUTH_NOT_VALID)
Aug 27 14:50:02 strephon wpa_supplicant[5906]: nl80211: send_event_marker failed: Source based routing not supported
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-DISCONNECTED bssid=48:b4:c3:81:b7:b3 reason=2 locally_generated=1
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: Added BSSID 48:b4:c3:81:b7:b3 into ignore list, ignoring for 10 seconds
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: BSSID 48:b4:c3:81:b7:b3 ignore list count incremented to 2, ignoring for 10 seconds
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-DSCP-POLICY clear_all
Aug 27 14:50:02 strephon NetworkManager[978]: <info>  [1724784602.2273] device (wlan0): supplicant interface state: completed -> disconnected
Aug 27 14:50:02 strephon NetworkManager[978]: <info>  [1724784602.2275] device (p2p-dev-wlan0): supplicant management interface state: completed -> disconnected
Aug 27 14:50:02 strephon NetworkManager[978]: <info>  [1724784602.3249] device (wlan0): supplicant interface state: disconnected -> scanning
Aug 27 14:50:02 strephon NetworkManager[978]: <info>  [1724784602.3249] device (p2p-dev-wlan0): supplicant management interface state: disconnected -> scanning
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:81:b7:d3 1
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:81:b7:c3 1
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:81:b7:e3 1
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:81:b7:f3 1
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 54:d7:e3:d9:91:22 1
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED e8:10:98:7c:2d:52 1
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:81:b1:80 1
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED e8:10:98:7c:2d:42 1
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:81:b1:90 1
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED dc:b7:ac:e3:18:b1 1
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED dc:b7:ac:e3:18:a1 1
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:81:c7:93 1
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:81:af:c3 1
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:80:58:a1 1
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 54:d7:e3:d9:91:32 1
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 54:d7:e3:d9:91:12 1
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:81:af:b3 1
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:4a:e9:c1:6c:31 1
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:81:ac:23 1
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:81:cc:33 1
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:81:c8:d2 1
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:81:ac:33 1
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:81:c8:e2 1
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: SME: Trying to authenticate with 48:b4:c3:81:b7:d3 (SSID='Harvard Secure' freq=6535 MHz)
Aug 27 14:50:02 strephon kernel: wlan0: authenticate with 48:b4:c3:81:b7:d3 (local address=3e:de:7e:33:e6:22)
Aug 27 14:50:02 strephon kernel: wlan0: send auth to 48:b4:c3:81:b7:d3 (try 1/3)
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: Trying to associate with 48:b4:c3:81:b7:d3 (SSID='Harvard Secure' freq=6535 MHz)
Aug 27 14:50:02 strephon kernel: wlan0: authenticated
Aug 27 14:50:02 strephon kernel: wlan0: associate with 48:b4:c3:81:b7:d3 (try 1/3)
Aug 27 14:50:02 strephon NetworkManager[978]: <info>  [1724784602.9674] device (wlan0): supplicant interface state: scanning -> authenticating
Aug 27 14:50:02 strephon NetworkManager[978]: <info>  [1724784602.9674] device (p2p-dev-wlan0): supplicant management interface state: scanning -> authenticating
Aug 27 14:50:02 strephon NetworkManager[978]: <info>  [1724784602.9675] device (wlan0): supplicant interface state: authenticating -> associating
Aug 27 14:50:02 strephon NetworkManager[978]: <info>  [1724784602.9675] device (p2p-dev-wlan0): supplicant management interface state: authenticating -> associating
Aug 27 14:50:02 strephon kernel: wlan0: RX AssocResp from 48:b4:c3:81:b7:d3 (capab=0x111 status=0 aid=16)
Aug 27 14:50:02 strephon kernel: wlan0: associated
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: Associated with 48:b4:c3:81:b7:d3
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-STARTED EAP authentication started
Aug 27 14:50:02 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-SUBNET-STATUS-UPDATE status=0
Aug 27 14:50:02 strephon NetworkManager[978]: <info>  [1724784602.9837] device (wlan0): supplicant interface state: associating -> associated
Aug 27 14:50:02 strephon NetworkManager[978]: <info>  [1724784602.9838] device (p2p-dev-wlan0): supplicant management interface state: associating -> associated
Aug 27 14:50:03 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-PROPOSED-METHOD vendor=0 method=13
Aug 27 14:50:03 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-METHOD EAP vendor 0 method 13 (TLS) selected
Aug 27 14:50:03 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-SUCCESS EAP authentication completed successfully
Aug 27 14:50:03 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-REMOVED 48:b4:c3:81:b7:d3 1
Aug 27 14:50:03 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:81:b7:d3 1
Aug 27 14:50:03 strephon NetworkManager[978]: <info>  [1724784603.1089] device (wlan0): supplicant interface state: associated -> 4way_handshake
Aug 27 14:50:03 strephon NetworkManager[978]: <info>  [1724784603.1090] device (p2p-dev-wlan0): supplicant management interface state: associated -> 4way_handshake
Aug 27 14:50:03 strephon wpa_supplicant[5906]: wlan0: WPA: Key negotiation completed with 48:b4:c3:81:b7:d3 [PTK=CCMP GTK=CCMP]
Aug 27 14:50:03 strephon wpa_supplicant[5906]: wlan0: Removed BSSID 48:b4:c3:81:b7:d3 from ignore list
Aug 27 14:50:03 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-CONNECTED - Connection to 48:b4:c3:81:b7:d3 completed [id=1 id_str=]
Aug 27 14:50:03 strephon NetworkManager[978]: <info>  [1724784603.1655] device (wlan0): supplicant interface state: 4way_handshake -> completed
Aug 27 14:50:03 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-43 noise=9999 txrate=245000
Aug 27 14:50:03 strephon NetworkManager[978]: <info>  [1724784603.1665] device (wlan0): ip:dhcp4: restarting
Aug 27 14:50:03 strephon NetworkManager[978]: <info>  [1724784603.1778] dhcp4 (wlan0): canceled DHCP transaction
Aug 27 14:50:03 strephon NetworkManager[978]: <info>  [1724784603.1778] dhcp4 (wlan0): activation: beginning transaction (timeout in 45 seconds)
Aug 27 14:50:03 strephon NetworkManager[978]: <info>  [1724784603.1778] dhcp4 (wlan0): state changed no lease
Aug 27 14:50:03 strephon NetworkManager[978]: <info>  [1724784603.1779] dhcp4 (wlan0): activation: beginning transaction (timeout in 45 seconds)
Aug 27 14:50:03 strephon NetworkManager[978]: <info>  [1724784603.1780] device (p2p-dev-wlan0): supplicant management interface state: 4way_handshake -> completed
Aug 27 14:50:03 strephon NetworkManager[978]: <info>  [1724784603.1851] dhcp4 (wlan0): state changed new lease, address=10.250.66.194, acd pending
Aug 27 14:50:03 strephon NetworkManager[978]: <info>  [1724784603.1853] dhcp4 (wlan0): state changed new lease, address=10.250.66.194
Aug 27 14:50:13 strephon systemd[1]: NetworkManager-dispatcher.service: Deactivated successfully.


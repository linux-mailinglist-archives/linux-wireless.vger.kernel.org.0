Return-Path: <linux-wireless+bounces-33865-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMjLG10ixGmZwgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33865-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 18:58:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACD532A33D
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 18:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD2383010926
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 17:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251D7410D07;
	Wed, 25 Mar 2026 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyQqQFlS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F7340FDA8;
	Wed, 25 Mar 2026 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461438; cv=none; b=bUtq3GeNH0vzRG0bCb8LH/O6Hq/MNKUiCj00u0dQyiCXQK8v7iPPq0u8+zEt7p973Sv0qCZK4KxEJH+18PjlclLG0IkzmqwJBokfjAF5Fp3CyWm65Nzm/zWrM8ZlS/jWoJ9nVuZX6lE98B+KbzzIZ2+XmQJ8XLkxi5m09T+e40c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461438; c=relaxed/simple;
	bh=l+Sa6PHie0+76HOU1LeHnQNEt+3sCVhiCKKJMpio3TI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JfZgR7UTXBz5bggzAB58Xwd/bjEgaCJyWkwe8V0AJER9irfryU8MTVQVnP0rT+4Y145yWRaY2+7S7qePfB6M7Jfy1/yeI5PAf3Kwrs75XSZWJ31yKu9/XJkrytMURMf+CYW4zkCQpi4ADaFx5XOULWOcDdKAgIABKnlNlt+bQDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyQqQFlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC6E7C2BCB1;
	Wed, 25 Mar 2026 17:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774461438;
	bh=l+Sa6PHie0+76HOU1LeHnQNEt+3sCVhiCKKJMpio3TI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=LyQqQFlStrqXuLb5r08huZTd85F+NyFKXuJxU+45+FdxMTwneGrNm5lkTSvM7ZflR
	 Vqj3xchr/HuM2tw4tQwKeVPP9RFvhKLZwE4l1knBsAL1NLNzrpTLDV/rb1azFomtI0
	 Paz8Wa2Dz7n9m179NvK7CZzW8/+MeVnUWOJqbGCO/zffxo4/skx98M0DTKCPbru3kP
	 dNz4fgdPssP5ZPUWdMV7z3PhwfGKNj385vA9kG9z7g2Az4wZyyjnNyljCbjfQDBjlM
	 hHGFBqeTnJt7rIqfHfd8GaeWc65HmzXPUQtMrRCWhZN8lkS1TSUPt/PPtH8AG7+Iwm
	 5kXL7cNn5xNPw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A77109C040;
	Wed, 25 Mar 2026 17:57:17 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v4 0/3] ath10k: Introduce a devicetree quirk to skip host
 cap QMI requests
Date: Wed, 25 Mar 2026 18:57:14 +0100
Message-Id: <20260325-skip-host-cam-qmi-req-v4-0-bc08538487aa@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPohxGkC/4XOTW6DMBAF4KtEXnci/2DHZJV7VFkYM8CoMSY2R
 Ukj7l6DVHVVdTPSW8z33otlTISZnQ8vlnChTHEsoXo7MD+4sUegtmQmudRCCA75gyYYYp7BuwD
 3QJDwDii0NtJi41XNyu+UsKPH7r5fS+5SDDAPCd2uCcMF11ZbAaKuTLnQ0wwZxxYwOLqBCzQfp
 8+xpXS50ehSPMbUb/RAeY7puS9e5Fbw37hFAgfeuq6y2tX25C70KLr/Ytu0Rf0Yhiup/zJUMRp
 hlO9OjfJW/Brrun4D2U6Qa0cBAAA=
X-Change-ID: 20251110-skip-host-cam-qmi-req-e155628ebc39
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Paul Sajna <sajattack@postmarketos.org>
Cc: Amit Pundir <amit.pundir@linaro.org>, linux-wireless@vger.kernel.org, 
 devicetree@vger.kernel.org, ath10k@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2045; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=l+Sa6PHie0+76HOU1LeHnQNEt+3sCVhiCKKJMpio3TI=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpxCH7ElA0Nd5DUi8t0QqcUigdI3QY//8k7Dyqz
 jRky/PwpA+JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCacQh+wAKCRBgAj/E00kg
 coh6D/9AsFFPwvKeFoEmXBxHBif+w1qdamrOK/Ez4rcrIsTVlItX5wcf0yvYzIqKrSlCUphp+VT
 Z6Yhj3aT2UZvsS3qgXPwQtHqaTEAeHRgFzYq+pAgPat953/4tI4TS1ca0EsFIw0WDLU4R6THF/L
 74IB2IPQHC9kjNEDJemH9hrq9pFljUIVClfY3v/BQ4jocazqY50lMqIoKiGORKAR0+tNmGZQ14J
 z/MCGoE+aFkpa2sT0Y4ZvE3fh3i0XmKd/WPtH/hxvvXtvrEYHGzeCe+eXYkKpcAuA26837an0fw
 dvTgC+XehXWRTASnhgWZxS1IcFizrAIUub9JNw00qjZuGTrJKuQ7GJWCPlgzMX9XxL3hrbLS+t3
 st4RAVjGZ0+dDqS9Syh/3ARmo28jsHaC3StTM1NfLWmiizOz+O5BxfmRs0YHC3p+z/bVyGM9Clz
 v3+aBR58MiZojkFjYR41592dQNzxwRbRcru4lvvNY1plFKADVL7DeFPMMD/aNKfHEi4tqN6cKwV
 3DK8BW41yVsw9djWl8S0s08GLaUDKTQMTKB2SB12bQ/KguMb3yLYLfPWywonmPBdRJbqQ9IwhrV
 NOFr72aIKW0pWa5PAHFt6rdFamToZHz2vZV4Ekk9SWRiF2tr2jezhkOyFA+Kyu1Lk8YrADVRj0G
 sA0j4vvHSlRZIlA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33865-lists,linux-wireless=lfdr.de,david.ixit.cz];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[david@ixit.cz];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ixit.cz:email,ixit.cz:replyto,ixit.cz:mid]
X-Rspamd-Queue-Id: 7ACD532A33D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This quirk is used so far used on:
 - LG G7 ThinQ
 - Xiaomi Poco F1

I'm resending it after ~ 4 years since initial send due to Snapdragon
845 being one of best supported platform for mobile phones running
Linux, so it would be shame to not have shiny support.

Original thread:
  https://lore.kernel.org/all/b796bfee-b753-479a-a8d6-ba1fe3ee6222@ixit.cz/

I tried the embedding the information inside the firmware, but the
information is required *before* loading the firmware itself.
Firmware quirk thread:
  https://lore.kernel.org/linux-wireless/20251111-xiaomi-beryllium-firmware-v1-0-836b9c51ad86@ixit.cz/

Until merged, available also at:
  https://codeberg.org/sdm845/linux/commits/branch/b4/skip-host-cam-qmi-req

Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v4:
- Added my own missing SoB. (Dmitry)
- Improve the commit message. (Dmitry)
- Link to v3: https://lore.kernel.org/r/20260325-skip-host-cam-qmi-req-v3-0-b163cf7b3c81@ixit.cz

Changes in v3:
- Rebased on recent linux-next (next-20260325).
- Improved motivation and description. (Dmitry)
- Link to v2: https://lore.kernel.org/r/20251110-skip-host-cam-qmi-req-v2-0-0daf485a987a@ixit.cz

---
Amit Pundir (3):
      dt-bindings: wireless: ath10k: Add quirk to skip host cap QMI requests
      ath10k: Add device-tree quirk to skip host cap QMI requests
      arm64: dts: qcom: sdm845-xiaomi-beryllium: Enable ath10k host-cap skip quirk

 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml       |  6 ++++++
 .../arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi |  1 +
 drivers/net/wireless/ath/ath10k/qmi.c                       | 13 ++++++++++---
 drivers/net/wireless/ath/ath10k/snoc.c                      |  3 +++
 drivers/net/wireless/ath/ath10k/snoc.h                      |  1 +
 5 files changed, 21 insertions(+), 3 deletions(-)
---
base-commit: 85964cdcad0fac9a0eb7b87a0f9d88cc074b854c
change-id: 20251110-skip-host-cam-qmi-req-e155628ebc39

Best regards,
-- 
David Heidelberg <david@ixit.cz>



